package dao;

import model.Transaction;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {
    public static boolean withdraw(int userId, double amount) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        String checkBalanceSQL = "SELECT balance FROM users WHERE id = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkBalanceSQL);
        checkStmt.setInt(1, userId);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next() && rs.getDouble("balance") >= amount) {
            String withdrawSQL = "UPDATE users SET balance = balance - ? WHERE id = ?";
            PreparedStatement withdrawStmt = conn.prepareStatement(withdrawSQL);
            withdrawStmt.setDouble(1, amount);
            withdrawStmt.setInt(2, userId);
            withdrawStmt.executeUpdate();

            String logSQL = "INSERT INTO transactions (user_id, type, amount) VALUES (?, 'Withdraw', ?)";
            PreparedStatement logStmt = conn.prepareStatement(logSQL);
            logStmt.setInt(1, userId);
            logStmt.setDouble(2, amount);
            logStmt.executeUpdate();

            return true;
        }
        return false;
    }

    public static boolean transfer(int senderId, int receiverId, double amount) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        conn.setAutoCommit(false);

        String checkSQL = "SELECT balance FROM users WHERE id = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSQL);
        checkStmt.setInt(1, senderId);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next() && rs.getDouble("balance") >= amount) {
            String deductSQL = "UPDATE users SET balance = balance - ? WHERE id = ?";
            PreparedStatement deductStmt = conn.prepareStatement(deductSQL);
            deductStmt.setDouble(1, amount);
            deductStmt.setInt(2, senderId);
            deductStmt.executeUpdate();

            String addSQL = "UPDATE users SET balance = balance + ? WHERE id = ?";
            PreparedStatement addStmt = conn.prepareStatement(addSQL);
            addStmt.setDouble(1, amount);
            addStmt.setInt(2, receiverId);
            addStmt.executeUpdate();

            String logSQL = "INSERT INTO transactions (user_id, type, amount, target_user) VALUES (?, 'Transfer', ?, ?)";
            PreparedStatement logStmt = conn.prepareStatement(logSQL);
            logStmt.setInt(1, senderId);
            logStmt.setDouble(2, amount);
            logStmt.setInt(3, receiverId);
            logStmt.executeUpdate();

            conn.commit();
            return true;
        }
        conn.rollback();
        return false;
    }

    public static List<Transaction> getTransactions(int userId) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        String sql = "SELECT * FROM transactions WHERE user_id = ? ORDER BY timestamp DESC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        List<Transaction> transactions = new ArrayList<>();
        while (rs.next()) {
            transactions.add(new Transaction(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getString("type"),
                    rs.getDouble("amount"),
                    rs.getInt("target_user"),
                    rs.getTimestamp("timestamp")
            ));
        }
        return transactions;
    }
}
