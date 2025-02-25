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
<head><title>ATM Home</title></head>
<body>

<h2>Chào mừng, <%= user.getUsername() %>!</h2>
<p>Số dư: <%= user.getBalance() %> VND</p>

<a href="withdraw.jsp">Rút tiền</a> |
<a href="transfer.jsp">Chuyển tiền</a> |
<a href="transaction.jsp">Lịch sử giao dịch</a> |
<a href="LogoutServlet">Đăng xuất</a>

</body>
</html>
