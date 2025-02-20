<%--
  Created by IntelliJ IDEA.
  User: Nguyen
  Date: 2/20/2025
  Time: 10:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%
    String action = request.getParameter("action");

    if ("add".equals(action)) {
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        Product.addProduct(new Product(name, price, description));
        response.sendRedirect("product.jsp");
    } else if ("update".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        Product.updateProduct(new Product(id, name, price, description));
        response.sendRedirect("product.jsp");
    } else if ("delete".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        Product.deleteProduct(id);
        response.sendRedirect("product.jsp");
    }

    List<Product> products = Product.getAllProducts();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            background: #f4f6f9;
        }
        .container {
            max-width: 800px;
            background: white;
            padding: 20px;
            margin-top: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.8s ease-in-out;
        }
        .btn:hover {
            transform: scale(1.05);
            transition: all 0.3s;
        }
        .btn-delete {
            background: #dc3545;
            color: white;
        }
        .btn-update {
            background: #ffc107;
            color: white;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
            transition: background-color 0.3s;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="text-center text-primary">Product Management</h1>
    <a href="welcome.jsp" class="btn btn-primary mb-3"><i class="fa fa-arrow-left"></i> Back to Home</a>

    <form action="products" method="post" class="mb-4">
        <input type="hidden" name="action" value="add">
        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input type="text" name="name" class="form-control" placeholder="Enter product name" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Price</label>
            <input type="number" name="price" class="form-control" placeholder="Enter product price" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" placeholder="Enter product description" required></textarea>
        </div>
        <button type="submit" class="btn btn-success w-100"><i class="fa fa-plus"></i> Add Product</button>
    </form>

    <h1 class="text-center text-primary">Product List</h1>
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
        <% for (Product product : products) { %>
        <tr>
            <td><%= product.getId() %></td>
            <td><%= product.getName() %></td>
            <td><%= product.getPrice() %> $</td>
            <td><%= product.getDescription() %></td>
            <td>
                <form action="products" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this product?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= product.getId() %>">
                    <button type="submit" class="btn btn-delete btn-sm"><i class="fa fa-trash"></i> Delete</button>
                </form>
                <button class="btn btn-update btn-sm" data-bs-toggle="modal" data-bs-target="#updateModal<%= product.getId() %>">
                    <i class="fa fa-edit"></i> Update
                </button>
                <div class="modal fade" id="updateModal<%= product.getId() %>" tabindex="-1" aria-labelledby="updateLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Update Product</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <form action="products" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="id" value="<%= product.getId() %>">
                                    <div class="mb-3">
                                        <label class="form-label">Product Name</label>
                                        <input type="text" name="name" class="form-control" value="<%= product.getName() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Price</label>
                                        <input type="number" name="price" class="form-control" value="<%= product.getPrice() %>" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea name="description" class="form-control" required><%= product.getDescription() %></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary w-100"><i class="fa fa-save"></i> Save Changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>

