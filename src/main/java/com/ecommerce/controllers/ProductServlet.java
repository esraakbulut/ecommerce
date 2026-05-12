package com.ecommerce.controllers;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.models.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private ProductDAO productDAO;
    private com.ecommerce.dao.CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new com.ecommerce.dao.CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Product product = productDAO.getProductById(id);
            
            if (product != null) {
                com.ecommerce.models.Category category = categoryDAO.getCategoryById(product.getCategoryId());
                request.setAttribute("product", product);
                request.setAttribute("category", category);
                request.getRequestDispatcher("/product-detail.jsp").forward(request, response);
                return;
            }
        }
        
        // Ürün bulunamazsa veya id verilmezse anasayfaya yönlendir
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
