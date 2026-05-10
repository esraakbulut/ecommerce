package com.ecommerce.dao;

import com.ecommerce.models.CartItem;
import com.ecommerce.models.Order;
import com.ecommerce.models.OrderItem;
import com.ecommerce.models.User;
import com.ecommerce.utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /**
     * Transaction kullanarak Sipariş ve Sipariş Kalemlerini güvenli bir şekilde kaydeder.
     * Hata anında tüm işlemleri geri alır (Rollback).
     */
    public boolean createOrder(Order order, List<CartItem> cartItems) {
        Connection conn = null;
        PreparedStatement insertOrderStmt = null;
        PreparedStatement insertItemStmt = null;
        PreparedStatement updateStockStmt = null;
        ResultSet generatedKeys = null;
        boolean isSuccess = false;

        String insertOrderSQL = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
        String insertItemSQL = "INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";
        // Mevcut stok eksi satın alınan miktar
        String updateStockSQL = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";

        try {
            conn = DBUtil.getConnection();
            // Transaction'ı başlatıyoruz
            conn.setAutoCommit(false);

            // 1. orders tablosuna kayıt
            insertOrderStmt = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            insertOrderStmt.setInt(1, order.getUserId());
            insertOrderStmt.setDouble(2, order.getTotalAmount());
            insertOrderStmt.setString(3, order.getStatus());
            
            int orderAffectedRows = insertOrderStmt.executeUpdate();

            if (orderAffectedRows == 0) {
                throw new SQLException("Sipariş oluşturulamadı, hiçbir satır etkilenmedi.");
            }

            // Yeni oluşan siparişin ID'sini alıyoruz
            generatedKeys = insertOrderStmt.getGeneratedKeys();
            int newOrderId;
            if (generatedKeys.next()) {
                newOrderId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("Sipariş oluşturuldu ancak ID alınamadı.");
            }

            // 2. order_items tablosuna kayıtlar ve 3. stok düşürme işlemi
            insertItemStmt = conn.prepareStatement(insertItemSQL);
            updateStockStmt = conn.prepareStatement(updateStockSQL);

            for (CartItem item : cartItems) {
                double subtotal = item.getProduct().getPrice() * item.getQuantity();

                // Sipariş kalemini ekle
                insertItemStmt.setInt(1, newOrderId);
                insertItemStmt.setInt(2, item.getProduct().getId());
                insertItemStmt.setInt(3, item.getQuantity());
                insertItemStmt.setDouble(4, item.getProduct().getPrice());
                insertItemStmt.setDouble(5, subtotal);
                insertItemStmt.addBatch();

                // Stoğu güncelle
                updateStockStmt.setInt(1, item.getQuantity());
                updateStockStmt.setInt(2, item.getProduct().getId());
                updateStockStmt.setInt(3, item.getQuantity());
                updateStockStmt.addBatch();
            }

            // Batch (Toplu) işlemleri çalıştırıyoruz
            insertItemStmt.executeBatch();
            int[] stockUpdateResults = updateStockStmt.executeBatch();
            
            // Eğer stok güncelleme 0 dönerse (stok yetersizse) hataya düşür
            for (int result : stockUpdateResults) {
                if (result == 0) {
                     throw new SQLException("Stok yetersiz olduğu için sipariş tamamlanamadı.");
                }
            }

            // Her şey başarılıysa değişiklikleri kalıcı hale getir
            conn.commit();
            isSuccess = true;

        } catch (SQLException e) {
            System.err.println("Sipariş oluşturulurken hata (Transaction Rollback yapılıyor): " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback(); // Hata varsa veritabanını önceki haline döndür
                } catch (SQLException ex) {
                    System.err.println("Rollback sırasında hata: " + ex.getMessage());
                }
            }
        } finally {
            // Kaynakları manuel olarak temizliyoruz
            try { if (generatedKeys != null) generatedKeys.close(); } catch (SQLException e) {}
            try { if (updateStockStmt != null) updateStockStmt.close(); } catch (SQLException e) {}
            try { if (insertItemStmt != null) insertItemStmt.close(); } catch (SQLException e) {}
            try { if (insertOrderStmt != null) insertOrderStmt.close(); } catch (SQLException e) {}
            // Auto-commit'i eski haline getirip bağlantıyı kapatıyoruz
            try { 
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {}
        }

        return isSuccess;
    }

    /**
     * Belirli bir kullanıcının (müşterinin) kendi siparişlerini getirir.
     */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setUserId(rs.getInt("user_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setStatus(rs.getString("status"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("Müşteri siparişleri getirilirken hata: " + e.getMessage());
        }
        return orders;
    }

    /**
     * Admin paneli için tüm siparişleri ve hangi müşterinin verdiğini getirir.
     */
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        // Basit bir JOIN örneği ile kullanıcı ismini de çekebiliriz
        String sql = "SELECT o.*, u.full_name FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                order.setUser(user);
                
                orders.add(order);
            }
        } catch (SQLException e) {
            System.err.println("Tüm siparişler listelenirken hata: " + e.getMessage());
        }
        return orders;
    }

    /**
     * Admin veya Müşteri için Sipariş Detayını getirir (Order_Items dahil).
     */
    public Order getOrderById(int id) {
        Order order = null;
        String sqlOrder = "SELECT * FROM orders WHERE id = ?";
        String sqlItems = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection conn = DBUtil.getConnection()) {
            
            // 1. Siparişin temel bilgilerini çekiyoruz
            try (PreparedStatement pstmtOrder = conn.prepareStatement(sqlOrder)) {
                pstmtOrder.setInt(1, id);
                try (ResultSet rsOrder = pstmtOrder.executeQuery()) {
                    if (rsOrder.next()) {
                        order = new Order();
                        order.setId(rsOrder.getInt("id"));
                        order.setUserId(rsOrder.getInt("user_id"));
                        order.setOrderDate(rsOrder.getTimestamp("order_date"));
                        order.setTotalAmount(rsOrder.getDouble("total_amount"));
                        order.setStatus(rsOrder.getString("status"));
                    }
                }
            }

            // 2. Siparişe ait kalemleri (ürün detaylarını) çekiyoruz
            if (order != null) {
                List<OrderItem> items = new ArrayList<>();
                try (PreparedStatement pstmtItems = conn.prepareStatement(sqlItems)) {
                    pstmtItems.setInt(1, id);
                    try (ResultSet rsItems = pstmtItems.executeQuery()) {
                        while (rsItems.next()) {
                            OrderItem item = new OrderItem();
                            item.setId(rsItems.getInt("id"));
                            item.setOrderId(rsItems.getInt("order_id"));
                            item.setProductId(rsItems.getInt("product_id"));
                            item.setQuantity(rsItems.getInt("quantity"));
                            item.setUnitPrice(rsItems.getDouble("unit_price"));
                            item.setSubtotal(rsItems.getDouble("subtotal"));
                            items.add(item);
                        }
                    }
                }
                order.setOrderItems(items);
            }

        } catch (SQLException e) {
            System.err.println("Sipariş detayı getirilirken hata: " + e.getMessage());
        }
        return order;
    }

    /**
     * Admin paneli üzerinden siparişin durumunu günceller.
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Sipariş durumu güncellenirken hata: " + e.getMessage());
            return false;
        }
    }
}
