<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/login_demo"
                   user="root" password="" />

<c:catch var="error">
    <!-- Insert Product -->
    <c:if test="${param.action == 'insert' and not empty param.name and not empty param.price}">
        <sql:update dataSource="${db}">
            INSERT INTO products (name, price, description) VALUES (?, ?, ?);
            <sql:param value="${param.name}" />
            <sql:param value="${param.price}" />
            <sql:param value="${param.description}" />
        </sql:update>
    </c:if>

    <!-- Update Product -->
    <c:if test="${param.action == 'update' and not empty param.id and not empty param.name and not empty param.price}">
        <sql:update dataSource="${db}">
            UPDATE products SET name = ?, price = ?, description = ? WHERE id = ?;
            <sql:param value="${param.name}" />
            <sql:param value="${param.price}" />
            <sql:param value="${param.description}" />
            <sql:param value="${param.id}" />
        </sql:update>
    </c:if>

    <!-- Delete Product -->
    <c:if test="${param.action == 'delete' and not empty param.id}">
        <sql:update dataSource="${db}">
            DELETE FROM products WHERE id = ?;
            <sql:param value="${param.id}" />
        </sql:update>
    </c:if>

    <!-- Fetch Product List -->
    <sql:query dataSource="${db}" var="productList">
        SELECT * FROM products;
    </sql:query>
</c:catch>

<c:if test="${not empty error}">
    <p class="text-danger">${error}</p>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body { background: #f4f6f9; }
        .container {
            max-width: 800px;
            background: white;
            padding: 20px;
            margin-top: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.8s ease-in-out;
        }
        .btn:hover { transform: scale(1.05); transition: all 0.3s; }
        .btn-delete { background: #dc3545; color: white; }
        .btn-update { background: #ffc107; color: white; }
        .table-hover tbody tr:hover { background-color: #f1f1f1; transition: background-color 0.3s; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
<div class="container">
    <h1 class="text-center text-primary">Product Management</h1>
    <a href="welcome.jsp" class="btn btn-primary mb-3"><i class="fa fa-arrow-left"></i> Back to Home</a>

    <!-- Form Thêm Sản Phẩm -->
    <h2 class="text-success">Add New Product</h2>
    <form method="post">
        <input type="hidden" name="action" value="insert">
        <div class="mb-3">
            <input type="text" name="name" class="form-control" placeholder="Enter Product Name" required>
        </div>
        <div class="mb-3">
            <input type="number" name="price" class="form-control" placeholder="Enter Price" required>
        </div>
        <div class="mb-3">
            <input type="text" name="description" class="form-control" placeholder="Enter Description" required>
        </div>
        <button type="submit" class="btn btn-success">Add Product</button>
    </form>

    <h2 class="text-primary text-center">Product List</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-primary">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${productList.rows}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td>${product.description}</td>
                <td>
                    <button type="button" class="btn btn-update edit-btn" data-id="${product.id}">
                        <i class="fa fa-edit"></i> Edit
                    </button>
                    <form method="post" class="update-form" id="form-${product.id}" style="display: none;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="${product.id}">
                        <input type="text" name="name" value="${product.name}" required>
                        <input type="number" name="price" value="${product.price}" required>
                        <input type="text" name="description" value="${product.description}" required>
                        <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> Save</button>
                    </form>
                    <form method="post" style="display:inline-block;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${product.id}">
                        <button type="submit" class="btn btn-delete"><i class="fa fa-trash"></i> Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".edit-btn").forEach(button => {
            button.addEventListener("click", function () {
                let id = this.getAttribute("data-id");
                let form = document.getElementById("form-" + id);
                form.style.display = (form.style.display === "none") ? "block" : "none";
            });
        });
    });
</script>
</body>
</html>
