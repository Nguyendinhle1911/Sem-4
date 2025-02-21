<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Kết nối đến MySQL
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/login_demo", "root", "");

                // Kiểm tra đăng nhập
                String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    session.setAttribute("username", username);
                    response.sendRedirect("welcome.jsp"); // Chuyển hướng sau khi đăng nhập thành công
                    return;
                } else {
                    error = "Tên đăng nhập hoặc mật khẩu không đúng!";
                }

            } catch (Exception e) {
                error = "Lỗi hệ thống: " + e.getMessage();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ignored) {}
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { background: linear-gradient(to right, #4facfe, #00f2fe); height: 100vh; }
        .login-container { width: 350px; padding: 20px; background: white; border-radius: 10px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2); animation: fadeIn 1s ease-in-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        .password-wrapper { position: relative; }
        .password-wrapper .toggle-password { position: absolute; right: 10px; top: 72%; transform: translateY(-50%); cursor: pointer; }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center">

<div class="login-container text-center">
    <h2 class="mb-4 text-primary">Đăng nhập</h2>
    <form action="login.jsp" method="post">
        <div class="mb-3 text-start">
            <label for="username" class="form-label">Tên đăng nhập</label>
            <input type="text" class="form-control" name="username" id="username" required>
        </div>
        <div class="mb-3 text-start password-wrapper">
            <label for="password" class="form-label">Mật khẩu</label>
            <input type="password" class="form-control" name="password" id="password" required>
            <i class="fa fa-eye toggle-password" onclick="togglePassword()"></i>
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
        <% if (!error.isEmpty()) { %>
        <p class="text-danger mt-3"><%= error %></p>
        <% } %>
    </form>
</div>

<script>
    function togglePassword() {
        var passwordInput = document.getElementById("password");
        var icon = document.querySelector(".toggle-password");
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            passwordInput.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>
</body>
</html>
