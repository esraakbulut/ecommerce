package com.ecommerce.controllers;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    // Giriş formunu göster
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    // Formdan gelen verilerle girişi doğrula
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.loginUser(email, password);

        if (user != null) {
            // Başarılı giriş, Session oluştur
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);

            // Eğer admin ise admin paneline, müşteri ise anasayfaya yönlendir
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            // Hatalı giriş
            request.setAttribute("errorMessage", "E-posta veya şifre hatalı!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
