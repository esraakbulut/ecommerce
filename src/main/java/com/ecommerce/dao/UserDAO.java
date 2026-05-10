package com.ecommerce.dao;

import com.ecommerce.models.User;
import com.ecommerce.utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    /**
     * Yeni bir kullanıcı kaydeder (E-posta tekrarını önleyerek).
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password, phone, address) VALUES (?, ?, ?, ?, ?)";
        
        // try-with-resources kullanarak bağlantıları ve statementları otomatik kapatıyoruz
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword()); // Gerçek projelerde hash'lenmiş şifre verilmeli
            pstmt.setString(4, user.getPhone());
            pstmt.setString(5, user.getAddress());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Kullanıcı kaydedilirken hata (Muhtemelen E-posta zaten kayıtlı): " + e.getMessage());
            return false;
        }
    }

    /**
     * E-posta ve şifre ile kullanıcı girişi kontrolü yapar.
     * Başarılıysa kullanıcı nesnesini, başarısızsa null döner.
     */
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        User user = null;
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Giriş yapılırken hata: " + e.getMessage());
        }
        
        return user;
    }

    /**
     * Admin paneli için veritabanındaki tüm kullanıcıları listeler.
     */
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
             
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                // Şifre gibi hassas verileri özellikle admin listesine eklemeyebiliriz, null kalabilir.
                userList.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Kullanıcılar listelenirken hata: " + e.getMessage());
        }
        
        return userList;
    }
}
