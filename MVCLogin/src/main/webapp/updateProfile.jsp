<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/15/2025
  Time: 11:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String oldUsername = (String) session.getAttribute("username");
    if (oldUsername == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String newUsername = request.getParameter("newUsername");
    String newPassword = request.getParameter("newPassword");

    String dbURL = "jdbc:mysql://localhost:3306/login_demo";
    String dbUser = "root";
    String dbPassword = "";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Cập nhật username và password trong database
        String sql = "UPDATE users SET username = ?, password = ? WHERE username = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, newUsername);
        stmt.setString(2, newPassword);
        stmt.setString(3, oldUsername);
        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            session.setAttribute("username", newUsername);
            out.println("<p>Thông tin đã được cập nhật!</p>");
        } else {
            out.println("<p>Cập nhật thất bại!</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="welcome.jsp">Quay lại</a>
