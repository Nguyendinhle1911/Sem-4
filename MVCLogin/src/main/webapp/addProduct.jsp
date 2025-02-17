<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/17/2025
  Time: 5:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm</title>
</head>
<body>
<h2>Thêm sản phẩm mới</h2>

<form action="product" method="post">
    <input type="hidden" name="action" value="add">

    <label for="name">Tên sản phẩm:</label>
    <input type="text" id="name" name="name" required><br>

    <label for="price">Giá:</label>
    <input type="number" id="price" name="price" step="0.01" required><br>

    <label for="description">Mô tả:</label>
    <input type="text" id="description" name="description" required><br>

    <label for="quantity">Số lượng:</label>
    <input type="number" id="quantity" name="quantity" required><br>

    <input type="submit" value="Thêm sản phẩm">
</form>
</body>
</html>
