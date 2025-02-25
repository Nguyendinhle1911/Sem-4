<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/25/2025
  Time: 11:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Chuyển tiền</title></head>
<body>
<form action="TransferServlet" method="post">
    <label>ID người nhận:</label>
    <input type="number" name="receiverId" required>
    <label>Số tiền:</label>
    <input type="number" name="amount" required>
    <input type="submit" value="Chuyển tiền">
</form>
</body>
</html>

