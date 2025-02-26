<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp"); // Chuyển hướng nếu chưa đăng nhập
        return;
    }
%>

<html>
<head>
    <title>ATM Home</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        .btn { padding: 10px 20px; font-size: 16px; cursor: pointer; }
        .logout-btn { background-color: red; color: white; border: none; }
    </style>
</head>
<body>

<h2>Chào mừng, <%= user.getUsername() %>!</h2>
<p>Số dư: <%= user.getBalance() %> VND</p>

<a href="withdraw.jsp">Rút tiền</a> |
<a href="transfer.jsp">Chuyển tiền</a> |
<a href="transaction.jsp">Lịch sử giao dịch</a>

<!-- Form để xử lý Logout -->
<form action="LogoutServlet" method="get" style="display:inline;">
    <button type="submit" class="btn logout-btn">Đăng xuất</button>
</form>

</body>
</html>
