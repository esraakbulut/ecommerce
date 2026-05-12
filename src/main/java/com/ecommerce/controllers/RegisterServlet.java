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
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Sunucu Tarafı Doğrulama (Server-side Validation)
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Ad soyad, e-posta ve şifre alanları zorunludur.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password); // Gerçek projelerde hashlenmeli
        user.setPhone(phone);
        user.setAddress(address);

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
