<%--
  Created by IntelliJ IDEA.
  User: ss
  Date: 13/02/2025
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if(session.getAttribute("username") == null){
        response.sendRedirect("login.jsp");
    }
%>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
<h1>Welcome, <%= session.getAttribute("username") %></h1>

<a href="logout">Logout</a>
<a href="editProfile.jsp">Chỉnh sửa thông tin</a>
<a href="productList.jsp">sản phẩm</a>
</body>
</html>

