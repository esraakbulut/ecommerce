package com.ecommerce.controllers;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        User user = new User();
        user.setFullName(request.getParameter("fullName"));
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password")); // Gerçek projelerde hashlenmeli
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));

        boolean isRegistered = userDAO.registerUser(user);

        if (isRegistered) {
            // Başarılı kayıtta girişe yönlendir
            response.sendRedirect(request.getContextPath() + "/login?registered=true");
        } else {
            // E-posta zaten varsa hata mesajı dön
            request.setAttribute("errorMessage", "Bu e-posta adresi zaten kullanılıyor!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
