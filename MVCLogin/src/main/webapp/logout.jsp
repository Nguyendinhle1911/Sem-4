<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/15/2025
  Time: 11:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.invalidate(); // Hủy session
    response.sendRedirect("login.jsp"); // Chuyển hướng về trang login
%>

