package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/login_demo";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    // Tách code thực hiện thêm, sửa, xóa vào các phương thức riêng biệt
    private void addProduct(Connection conn, String name, double price, String description, int quantity) throws SQLException {
        String sql = "INSERT INTO products (name, price, description, quantity) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setString(3, description);
            stmt.setInt(4, quantity);
            stmt.executeUpdate();
        }
    }

    private void deleteProduct(Connection conn, int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    private void editProduct(Connection conn, int id, String name, double price, String description, int quantity) throws SQLException {
        String sql = "UPDATE products SET name=?, price=?, description=?, quantity=? WHERE id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setString(3, description);
            stmt.setInt(4, quantity);
            stmt.setInt(5, id);
            stmt.executeUpdate();
        }
    }

    // Tạo phương thức lấy sản phẩm theo ID
    private Product getProductById(Connection conn, int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setQuantity(rs.getInt("quantity"));
                return product;
            }
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("product.jsp");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            if (action.equals("add")) {
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("description");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                addProduct(conn, name, price, description, quantity);
                // Chuyển hướng tới trang danh sách sản phẩm sau khi thêm
                request.setAttribute("message", "Sản phẩm đã được thêm thành công.");
                request.getRequestDispatcher("productList.jsp").forward(request, response);
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                deleteProduct(conn, id);
                // Chuyển hướng đến trang danh sách sản phẩm sau khi xóa
                request.setAttribute("message", "Sản phẩm đã được xóa.");
                request.getRequestDispatcher("productList.jsp").forward(request, response);
            } else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                String description = request.getParameter("description");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                editProduct(conn, id, name, price, description, quantity);
                // Chuyển hướng đến trang danh sách sản phẩm sau khi sửa
                request.setAttribute("message", "Sản phẩm đã được cập nhật.");
                request.getRequestDispatcher("productList.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra, vui lòng thử lại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Product> productList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM products";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {

                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("id"));
                    product.setName(rs.getString("name"));
                    product.setPrice(rs.getDouble("price"));
                    product.setDescription(rs.getString("description"));
                    product.setQuantity(rs.getInt("quantity"));
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải sản phẩm, vui lòng thử lại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("productList", productList);
        request.getRequestDispatcher("productList.jsp").forward(request, response);
    }
}
