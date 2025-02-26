<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f4f8;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        h2, h3 {
            color: #2c3e50;
        }
        table {
            width: 100%;
            max-width: 800px;
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
            background-color: #3498db;
            color: white;
        }
        tr:hover {
            background-color: #f5f6fa;
        }
        a {
            color: #2980b9;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .add-account-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            max-width: 450px;
        }
        .add-account-form input[type="text"],
        .add-account-form input[type="number"] {
            width: 100%;
            padding: 8px;
            margin: 8px 0 8px -10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .add-account-form input[type="submit"] {
            background-color: #27ae60;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
        .add-account-form input[type="submit"]:hover {
            background-color: #219653;
        }
        .delete-btn {
            background-color: #e74c3c;
            color: white;
            padding: 6px 10px;
            border: none;
            cursor: pointer;
        }
        .delete-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>
<h2>Welcome, ${sessionScope.user.username}</h2>
<h3>Your Accounts</h3>
<table border="1">
    <tr>
        <th>Account Number</th>
        <th>Balance</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="account" items="${sessionScope.accounts}">
        <tr>
            <td>${account.accountNumber}</td>
            <td>${account.balance}</td>
            <td>
                <a href="${pageContext.request.contextPath}/withdraw.jsp?accountId=${account.accountId}">Withdraw</a> |
                <a href="${pageContext.request.contextPath}/transfer.jsp?accountId=${account.accountId}">Transfer</a> |
                <a href="${pageContext.request.contextPath}/history?accountId=${account.accountId}">History</a> |
                <form action="${pageContext.request.contextPath}/accountManagement" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="accountId" value="${account.accountId}">
                    <input type="submit" value="Delete" class="delete-btn" onclick="return confirm('Are you sure?');">
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<h3>Add New Account</h3>
<form action="${pageContext.request.contextPath}/accountManagement" method="post" class="add-account-form">
    <input type="hidden" name="action" value="create">
    <input type="hidden" name="userId" value="${sessionScope.user.userId}">
    Account Number: <input type="text" name="accountNumber" required><br>
    Initial Balance: <input type="number" name="balance" step="0.01" required><br>
    <input type="submit" value="Add Account">
</form>
</body>
</html>