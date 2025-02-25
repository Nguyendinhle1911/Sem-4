<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/25/2025
  Time: 11:31 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Login</title></head>
<body>
<h2>Đăng nhập vào hệ thống ATM</h2>
<form action="LoginServlet" method="post">
    <label>Username:</label> <input type="text" name="username" required><br>
    <label>Password:</label> <input type="password" name="password" required><br>
    <input type="submit" value="Đăng nhập">
</form>
<c:if test="${not empty message}">
    <p style="color:red;">${message}</p>
</c:if>
</body>
</html>
