<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/17/2025
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
</head>
<body>
<h2>Sửa sản phẩm</h2>

<form action="product" method="post">
    <input type="hidden" name="action" value="edit">
    <input type="hidden" name="id" value="${product.id}">

    <label for="name">Tên sản phẩm:</label>
    <input type="text" id="name" name="name" value="${product.name}" required><br>

    <label for="price">Giá:</label>
    <input type="number" id="price" name="price" value="${product.price}" step="0.01" required><br>

    <label for="description">Mô tả:</label>
    <input type="text" id="description" name="description" value="${product.description}" required><br>

    <label for="quantity">Số lượng:</label>
    <input type="number" id="quantity" name="quantity" value="${product.quantity}" required><br>

    <input type="submit" value="Cập nhật sản phẩm">
</form>
</body>
</html>

