<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/17/2025
  Time: 5:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Danh sách sản phẩm</title>
</head>
<body>
<h2>Danh sách sản phẩm</h2>

<!-- Hiển thị thông báo -->
<c:if test="${not empty message}">
  <p style="color: green;">${message}</p>
</c:if>
<c:if test="${not empty errorMessage}">
  <p style="color: red;">${errorMessage}</p>
</c:if>

<table border="1">
  <thead>
  <tr>
    <th>ID</th>
    <th>Tên sản phẩm</th>
    <th>Giá</th>
    <th>Mô tả</th>
    <th>Số lượng</th>
    <th>Hành động</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="product" items="${productList}">
    <tr>
      <td>${product.id}</td>
      <td>${product.name}</td>
      <td>${product.price}</td>
      <td>${product.description}</td>
      <td>${product.quantity}</td>
      <td>
        <!-- Sửa sản phẩm -->
        <a href="product?action=edit&id=${product.id}">Sửa</a> |
        <!-- Xóa sản phẩm -->
        <a href="product?action=delete&id=${product.id}" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

<!-- Thêm sản phẩm -->
<a href="addProduct.jsp">Thêm sản phẩm mới</a>
</body>
</html>
