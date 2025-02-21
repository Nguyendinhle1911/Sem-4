<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 900px;
            margin-top: 20px;
        }
        .card {
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        table {
            background: white;
            border-radius: 8px;
        }
        table tbody tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

<div class="container">
    <h1 class="text-center text-primary">Product Management</h1>
    <div class="text-center mb-3">
        <a href="welcome.jsp" class="btn btn-primary">Back to Home</a>
    </div>

    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/login_demo"
                       user="root" password="" />

    <c:if test="${param.action == 'add'}">
        <sql:update dataSource="${db}">
            INSERT INTO products (name, price, description) VALUES (?, ?, ?)
            <sql:param value="${param.name}" />
            <sql:param value="${param.price}" />
            <sql:param value="${param.description}" />
        </sql:update>
        <c:redirect url="product.jsp"/>
    </c:if>

    <c:if test="${param.action == 'delete'}">
        <sql:update dataSource="${db}">
            DELETE FROM products WHERE id = ?
            <sql:param value="${param.id}" />
        </sql:update>
        <c:redirect url="product.jsp"/>
    </c:if>

    <c:if test="${param.action == 'update'}">
        <sql:update dataSource="${db}">
            UPDATE products SET name=?, price=?, description=? WHERE id=?
            <sql:param value="${param.name}" />
            <sql:param value="${param.price}" />
            <sql:param value="${param.description}" />
            <sql:param value="${param.id}" />
        </sql:update>
        <c:redirect url="product.jsp"/>
    </c:if>

    <!-- Add Product Form -->
    <div class="card p-4 mb-4">
        <h3 class="text-center text-success">Add New Product</h3>
        <form action="product.jsp" method="post">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label class="form-label">Product Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Price</label>
                <input type="number" name="price" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" required></textarea>
            </div>
            <button type="submit" class="btn btn-success w-100">Add Product</button>
        </form>
    </div>

    <!-- Product List -->
    <h3 class="text-center text-primary">Product List</h3>
    <sql:query dataSource="${db}" var="products">SELECT * FROM products</sql:query>
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
        <c:forEach var="product" items="${products.rows}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.price} $</td>
                <td>${product.description}</td>
                <td>
                    <form action="product.jsp" method="post" class="d-inline">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${product.id}">
                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Delete</button>
                    </form>
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#updateModal${product.id}">Update</button>

                    <!-- Update Modal -->
                    <div class="modal fade" id="updateModal${product.id}" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content p-3">
                                <h5>Update Product</h5>
                                <form action="product.jsp" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="${product.id}">
                                    <input type="text" name="name" class="form-control mb-2" value="${product.name}" required>
                                    <input type="number" name="price" class="form-control mb-2" value="${product.price}" required>
                                    <textarea name="description" class="form-control mb-2">${product.description}</textarea>
                                    <button type="submit" class="btn btn-primary w-100">Save Changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
