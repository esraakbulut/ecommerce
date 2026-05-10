package com.ecommerce.controllers;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.models.CartItem;
import com.ecommerce.models.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Sepet sayfasını göster
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        // Session'da sepet yoksa oluştur
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Product product = productDAO.getProductById(productId);
            
            if (product != null && product.getStock() >= quantity) {
                boolean exists = false;
                // Ürün sepette zaten varsa miktarını artır
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == productId) {
                        item.setQuantity(item.getQuantity() + quantity);
                        exists = true;
                        break;
                    }
                }
                // Yoksa sepete yeni ürün ekle
                if (!exists) {
                    cart.add(new CartItem(product, quantity));
                }
            }
        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cart.removeIf(item -> item.getProduct().getId() == productId);
        } else if ("update".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            for (CartItem item : cart) {
                if (item.getProduct().getId() == productId) {
                    // Stok kontrolü
                    if (quantity <= item.getProduct().getStock()) {
                        item.setQuantity(quantity);
                    }
                    break;
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
