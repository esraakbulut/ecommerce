package com.ecommerce.controllers;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.models.Category;
import com.ecommerce.models.Product;
import com.ecommerce.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        return loggedInUser != null && "admin".equals(loggedInUser.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories(); // Formlarda dropdown için
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Product p = extractProductFromRequest(request);
                productDAO.addProduct(p);
                
            } else if ("update".equals(action)) {
                Product p = extractProductFromRequest(request);
                p.setId(Integer.parseInt(request.getParameter("id")));
                productDAO.updateProduct(p);
                
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                productDAO.deleteProduct(id);
            }
        } catch (IllegalArgumentException e) {
            // Sunucu tarafı doğrulama hatası (Fiyat < 0 vb.)
            request.getSession().setAttribute("errorMessage", e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }

    // Sunucu tarafı doğrulaması ile form verilerini okur
    private Product extractProductFromRequest(HttpServletRequest request) throws IllegalArgumentException {
        Product p = new Product();
        p.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        
        String name = request.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Ürün adı boş olamaz.");
        }
        p.setName(name);
        
        p.setDescription(request.getParameter("description"));
        
        double price = Double.parseDouble(request.getParameter("price"));
        if (price <= 0) {
            throw new IllegalArgumentException("Fiyat 0'dan büyük olmalıdır.");
        }
        p.setPrice(price);
        
        int stock = Integer.parseInt(request.getParameter("stock"));
        if (stock < 0) {
            throw new IllegalArgumentException("Stok negatif olamaz.");
        }
        p.setStock(stock);
        
        p.setImageUrl(request.getParameter("imageUrl"));
        p.setActive(request.getParameter("isActive") != null);
        
        return p;
    }
}
