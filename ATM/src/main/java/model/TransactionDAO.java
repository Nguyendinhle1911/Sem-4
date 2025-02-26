package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    public static boolean withdraw(int userId, double amount) throws SQLException {
        String checkBalanceSQL = "SELECT balance FROM users WHERE id = ?";
        String withdrawSQL = "UPDATE users SET balance = balance - ? WHERE id = ?";
        String logSQL = "INSERT INTO transactions (user_id, type, amount) VALUES (?, 'Withdraw', ?)";

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement checkStmt = conn.prepareStatement(checkBalanceSQL)) {
                checkStmt.setInt(1, userId);
                ResultSet rs = checkStmt.executeQuery();

                if (!rs.next() || rs.getDouble("balance") < amount) {
                    conn.rollback();
                    return false;
                }
            }

            try (PreparedStatement withdrawStmt = conn.prepareStatement(withdrawSQL)) {
                withdrawStmt.setDouble(1, amount);
                withdrawStmt.setInt(2, userId);
                withdrawStmt.executeUpdate();
            }

            try (PreparedStatement logStmt = conn.prepareStatement(logSQL)) {
                logStmt.setInt(1, userId);
                logStmt.setDouble(2, amount);
                logStmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean transfer(int senderId, int receiverId, double amount) throws SQLException {
        String checkSQL = "SELECT balance FROM users WHERE id = ?";
        String deductSQL = "UPDATE users SET balance = balance - ? WHERE id = ?";
        String addSQL = "UPDATE users SET balance = balance + ? WHERE id = ?";
        String logSQL = "INSERT INTO transactions (user_id, type, amount, target_user) VALUES (?, 'Transfer', ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement checkStmt = conn.prepareStatement(checkSQL)) {
                checkStmt.setInt(1, senderId);
                ResultSet rs = checkStmt.executeQuery();

                if (!rs.next() || rs.getDouble("balance") < amount) {
                    conn.rollback();
                    return false;
                }
            }

            try (PreparedStatement deductStmt = conn.prepareStatement(deductSQL)) {
                deductStmt.setDouble(1, amount);
                deductStmt.setInt(2, senderId);
                deductStmt.executeUpdate();
            }

            try (PreparedStatement addStmt = conn.prepareStatement(addSQL)) {
                addStmt.setDouble(1, amount);
                addStmt.setInt(2, receiverId);
                addStmt.executeUpdate();
            }

            try (PreparedStatement logStmt = conn.prepareStatement(logSQL)) {
                logStmt.setInt(1, senderId);
                logStmt.setDouble(2, amount);
                logStmt.setInt(3, receiverId);
                logStmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Transaction> getTransactions(int userId) throws SQLException {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM transactions WHERE user_id = ? ORDER BY timestamp DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            System.out.println("Executing SQL: " + stmt.toString());

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Transaction transaction = new Transaction(
                            rs.getInt("id"),
                            rs.getInt("user_id"),
                            rs.getString("type"),
                            rs.getDouble("amount"),
                            rs.getInt("target_user"),
                            rs.getTimestamp("timestamp")
                    );
                    transactions.add(transaction);
                    System.out.println("Fetched transaction: " + transaction.getId());
                }
            }
        }
        System.out.println("Total transactions fetched: " + transactions.size());
        return transactions;
    }

}
