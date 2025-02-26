<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Transaction History</title>
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
        table {
            width: 100%;
            max-width: 900px;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #e74c3c;
            color: white;
        }
        tr:hover {
            background-color: #f5f6fa;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            color: #2980b9;
            text-decoration: none;
            font-weight: bold;
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
<h2>Transaction History</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Type</th>
        <th>Amount</th>
        <th>Target Account ID</th>
        <th>Date</th>
    </tr>
    <c:forEach var="transaction" items="${requestScope.transactions}">
        <tr>
            <td>${transaction.transactionId}</td>
            <td>${transaction.type}</td>
            <td>${transaction.amount}</td>
            <td><c:out value="${transaction.targetAccountId != null ? transaction.targetAccountId : 'N/A'}" /></td>
            <td>${transaction.transactionDate}</td>
        </tr>
    </c:forEach>
</table>
<a href="${pageContext.request.contextPath}/dashboard.jsp">Back to Dashboard</a>
</body>
</html>