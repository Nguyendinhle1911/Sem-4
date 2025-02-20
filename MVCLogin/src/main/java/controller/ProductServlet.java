package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", value = "/products")
public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Product> productList = Product.getAllProducts();
            req.setAttribute("productList", productList);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Error loading products");
        }
        req.getRequestDispatcher("product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");

            Product product = new Product(name, price, description);
            Product.addProduct(product);

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("name");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");

            Product product = new Product(id, name, price, description);
            Product.updateProduct(product);

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product.deleteProduct(id);
        }

        resp.sendRedirect("products");
    }
}