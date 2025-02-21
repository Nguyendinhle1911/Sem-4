<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Product Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <script>
        function confirmAction(message, form) {
            if (confirm(message)) {
                form.submit();
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h1 class="text-center text-primary">Product Management</h1>
    <a href="welcome.jsp" class="btn btn-primary mb-3">Back to Home</a>

    <!-- Add Product Form -->
    <form action="products" method="post" class="mb-4" onsubmit="return confirm('Are you sure you want to add this product?');">
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
        <button type="submit" class="btn btn-success w-100">Add Product</button>
    </form>

    <!-- Product List -->
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
        <%
            List<Product> productList = (List<Product>) request.getAttribute("productList");
            if (productList != null && !productList.isEmpty()) {
                for (Product product : productList) {
        %>
        <tr>
            <td><%= product.getId() %></td>
            <td><%= product.getName() %></td>
            <td><%= product.getPrice() %> $</td>
            <td><%= product.getDescription() %></td>
            <td>
                <!-- Delete Product -->
                <form action="products" method="post" class="d-inline" onsubmit="event.preventDefault(); confirmAction('Are you sure you want to delete this product?', this);">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= product.getId() %>">
                    <button type="submit" class="btn btn-delete btn-sm">Delete</button>
                </form>

                <!-- Update Product -->
                <button class="btn btn-update btn-sm" data-bs-toggle="modal" data-bs-target="#updateModal<%= product.getId() %>">Update</button>

                <!-- Update Modal -->
                <div class="modal fade" id="updateModal<%= product.getId() %>" tabindex="-1" aria-labelledby="updateLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Update Product</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <form action="products" method="post" onsubmit="return confirm('Are you sure you want to update this product?');">
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
                                    <button type="submit" class="btn btn-primary w-100">Save Changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5" class="text-center">No products available.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
