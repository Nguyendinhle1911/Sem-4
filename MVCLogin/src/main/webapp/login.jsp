<%--
  Created by IntelliJ IDEA.
  User: ss
  Date: 13/02/2025
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="style.css">
<html>
<head>
    <title>Login From</title>
</head>
<body>
    <form action="login" method="post">
        Username: <input type="text" name="username">
        Password: <input type="password" name="password">
        <input type="submit" value="login">
    </form>
    <p style="color: red;">${error}</p>

</body>
</html>
