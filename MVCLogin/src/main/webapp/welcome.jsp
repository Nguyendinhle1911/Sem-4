<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Welcome</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f4f6f9;
        }
        .welcome-container {
            max-width: 600px;
            margin: 100px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }
        .btn-custom {
            flex: 1;
            padding: 10px;
            font-size: 18px;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="welcome-container">
        <h1 class="text-primary">Welcome, <%= session.getAttribute("username") %>!</h1>

        <div class="btn-container">
            <!-- Logout Form -->
            <form action="logout" method="post">
                <button type="submit" class="btn btn-danger btn-custom">Logout</button>
            </form>

            <!-- Product Management -->
            <a href="products" class="btn btn-success btn-custom">Manage Products</a>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
