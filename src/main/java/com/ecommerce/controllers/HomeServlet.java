package com.ecommerce.controllers;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.models.Category;
import com.ecommerce.models.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String catIdParam = request.getParameter("categoryId");
        List<Product> products;

        // Kategoriye göre filtreleme yapılmışsa
        if (catIdParam != null && !catIdParam.isEmpty()) {
            int categoryId = Integer.parseInt(catIdParam);
            products = productDAO.getProductsByCategoryId(categoryId);
            request.setAttribute("selectedCategoryId", categoryId);
        } else {
            // Filtreleme yoksa aktif tüm ürünleri getir
            products = productDAO.getActiveProducts();
        }

        // Filtreleme menüsü için aktif kategorileri getir
        List<Category> categories = categoryDAO.getActiveCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        // Verileri index.jsp'ye yolla
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
