package com.ecommerce.controllers;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.models.Category;
import com.ecommerce.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
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

        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Category cat = new Category();
            cat.setName(request.getParameter("name"));
            cat.setDescription(request.getParameter("description"));
            cat.setActive(request.getParameter("isActive") != null);
            categoryDAO.addCategory(cat);
            
        } else if ("update".equals(action)) {
            Category cat = new Category();
            cat.setId(Integer.parseInt(request.getParameter("id")));
            cat.setName(request.getParameter("name"));
            cat.setDescription(request.getParameter("description"));
            cat.setActive(request.getParameter("isActive") != null);
            categoryDAO.updateCategory(cat);
            
        } else if ("delete".equals(action)) { // Soft delete
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.deleteCategory(id);
        }

        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}
