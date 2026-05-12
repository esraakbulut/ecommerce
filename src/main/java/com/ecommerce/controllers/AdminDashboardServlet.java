package com.ecommerce.controllers;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.dao.UserDAO;
import com.ecommerce.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private OrderDAO orderDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Admin rolü kontrolü
        if (loggedInUser == null || !"admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Özet istatistikler için DAO'lardan veri çekiyoruz
        int totalProducts = productDAO.getAllProducts().size();
        int totalCategories = categoryDAO.getAllCategories().size();
        int totalOrders = orderDAO.getAllOrders().size();
        int totalUsers = userDAO.getAllUsers().size();
        
        int pendingOrders = (int) orderDAO.getAllOrders().stream()
                                  .filter(o -> "Beklemede".equals(o.getStatus()))
                                  .count();

        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("pendingOrders", pendingOrders);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}
