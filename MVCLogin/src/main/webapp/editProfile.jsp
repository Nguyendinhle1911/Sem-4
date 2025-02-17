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
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Chỉnh sửa thông tin</title>
</head>
<body>
<h1>Chỉnh sửa thông tin của <%= username %></h1>
<form action="updateProfile.jsp" method="post">
    <label for="newUsername">Tên đăng nhập mới:</label>
    <input type="text" id="newUsername" name="newUsername" required>
    <br>

    <label for="newPassword">Mật khẩu mới:</label>
    <input type="password" id="newPassword" name="newPassword" required>
    <br>

    <button type="submit">Cập nhật</button>
</form>
</body>
</html>

