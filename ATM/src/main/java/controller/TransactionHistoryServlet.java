package controller;

import model.TransactionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Transaction;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
@WebServlet("/TransactionHistoryServlet")
public class TransactionHistoryServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(TransactionHistoryServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");


        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Transaction> transactions = TransactionDAO.getTransactions(user.getId());
            request.setAttribute("transactions", transactions);

            // Kiểm tra số lượng giao dịch có lấy ra đúng không
            System.out.println("Total transactions fetched: " + transactions.size());

            request.getRequestDispatcher("transaction.jsp").forward(request, response);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy lịch sử giao dịch", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra, vui lòng thử lại sau.");
        }
        System.out.println("User ID: " + user.getId());
    }

}

