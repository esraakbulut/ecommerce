package com.ecommerce.controllers;

import com.ecommerce.dao.OrderDAO;
import com.ecommerce.models.CartItem;
import com.ecommerce.models.Order;
import com.ecommerce.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    // Sipariş geçmişini listele veya detay göster
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderIdParam = request.getParameter("id");

        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            // Sipariş detayını göster
            int orderId = Integer.parseInt(orderIdParam);
            Order order = orderDAO.getOrderById(orderId);
            
            // Güvenlik: Sadece kendi siparişini görebilsin (Admin kontrolü admin servlet'te olacak)
            if (order != null && order.getUserId() == loggedInUser.getId()) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/order-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/order");
            }
        } else {
            // Tüm siparişlerini listele
            List<Order> myOrders = orderDAO.getOrdersByUserId(loggedInUser.getId());
            request.setAttribute("orders", myOrders);
            request.getRequestDispatcher("/orders.jsp").forward(request, response);
        }
    }

    // Sepetten sipariş oluştur (Checkout)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");

        // Giriş yapılmamışsa login sayfasına at
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Sepetteki toplam tutarı hesapla
        double totalAmount = 0;
        for (CartItem item : cart) {
            totalAmount += item.getTotalPrice();
        }

        // Sipariş nesnesini oluştur
        Order newOrder = new Order();
        newOrder.setUserId(loggedInUser.getId());
        newOrder.setTotalAmount(totalAmount);
        newOrder.setStatus("Beklemede");

        // OrderDAO aracılığıyla (Transaction kullanılarak) siparişi kaydet
        boolean isSuccess = orderDAO.createOrder(newOrder, cart);

        if (isSuccess) {
            // Sipariş başarılıysa sepeti temizle
            session.removeAttribute("cart");
            // Siparişlerim sayfasına yönlendir (Başarı mesajı da eklenebilir)
            response.sendRedirect(request.getContextPath() + "/order?success=true");
        } else {
            // Hata olursa (Örn: Stok yetersiz)
            request.setAttribute("errorMessage", "Sipariş oluşturulurken bir hata oluştu. Stok yetersiz olabilir.");
            request.getRequestDispatcher("/cart.jsp").forward(request, response);
        }
    }
}
