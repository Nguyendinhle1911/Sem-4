<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/25/2025
  Time: 11:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Rút tiền</title></head>
<body>
<form action="WithdrawServlet" method="post">
  <label>Số tiền muốn rút:</label>
  <input type="number" name="amount" required>
  <input type="submit" value="Rút tiền">
</form>
<c:if test="${not empty message}">
  <p style="color:red;">${message}</p>
</c:if>
</body>
</html>
