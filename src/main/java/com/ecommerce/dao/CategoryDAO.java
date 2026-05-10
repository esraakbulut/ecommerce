package com.ecommerce.dao;

import com.ecommerce.models.Category;
import com.ecommerce.utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    /**
     * Admin paneli için tüm kategorileri listeler (aktif ve pasif olanlar dahil).
     */
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY id ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
             
            while (rs.next()) {
                Category cat = new Category();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
                cat.setActive(rs.getBoolean("is_active"));
                categories.add(cat);
            }
        } catch (SQLException e) {
            System.err.println("Kategoriler listelenirken hata: " + e.getMessage());
        }
        
        return categories;
    }

    /**
     * Müşteri tarafı için sadece aktif olan kategorileri getirir.
     */
    public List<Category> getActiveCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories WHERE is_active = true ORDER BY name ASC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
             
            while (rs.next()) {
                Category cat = new Category();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
                cat.setActive(rs.getBoolean("is_active"));
                categories.add(cat);
            }
        } catch (SQLException e) {
            System.err.println("Aktif kategoriler listelenirken hata: " + e.getMessage());
        }
        
        return categories;
    }

    /**
     * ID'ye göre tek bir kategoriyi getirir.
     */
    public Category getCategoryById(int id) {
        String sql = "SELECT * FROM categories WHERE id = ?";
        Category cat = null;
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, id);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cat = new Category();
                    cat.setId(rs.getInt("id"));
                    cat.setName(rs.getString("name"));
                    cat.setDescription(rs.getString("description"));
                    cat.setActive(rs.getBoolean("is_active"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Kategori getirilirken hata: " + e.getMessage());
        }
        
        return cat;
    }

    /**
     * Yeni bir kategori ekler.
     */
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO categories (name, description, is_active) VALUES (?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.setBoolean(3, category.isActive());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Kategori eklenirken hata: " + e.getMessage());
            return false;
        }
    }

    /**
     * Var olan bir kategoriyi günceller.
     */
    public boolean updateCategory(Category category) {
        String sql = "UPDATE categories SET name = ?, description = ?, is_active = ? WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.setBoolean(3, category.isActive());
            pstmt.setInt(4, category.getId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Kategori güncellenirken hata: " + e.getMessage());
            return false;
        }
    }

    /**
     * Veritabanından silmek yerine kategoriyi pasife çeker (Soft Delete).
     */
    public boolean deleteCategory(int id) {
        String sql = "UPDATE categories SET is_active = false WHERE id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setInt(1, id);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("Kategori silinirken (pasife çekilirken) hata: " + e.getMessage());
            return false;
        }
    }
}
