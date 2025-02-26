<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Withdraw</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        h2 {
            color: #2c3e50;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            max-width: 400px;
        }
        input[type="number"] {
            width: 100%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #8e44ad;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #732d91;
        }
        p {
            margin: 10px 0;
        }
        a {
            display: inline-block;
            margin-top: 10px;
            color: #2980b9;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>
<h2>Withdraw Money</h2>
<form action="${pageContext.request.contextPath}/withdraw" method="post">
    <input type="hidden" name="accountId" value="${param.accountId}">
    Amount: <input type="number" name="amount" step="0.01" required><br>
    <input type="submit" value="Withdraw">
</form>
<c:if test="${not empty requestScope.error}">
    <p style="color:red">${requestScope.error}</p>
</c:if>
<a href="${pageContext.request.contextPath}/dashboard.jsp">Back to Dashboard</a>
</body>
</html>