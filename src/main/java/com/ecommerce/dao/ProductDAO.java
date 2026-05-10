package com.ecommerce.dao;

import com.ecommerce.models.Product;
import com.ecommerce.utils.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    /**
     * ResultSet'ten Product nesnesi oluşturan yardımcı metot (Kod tekrarını önlemek için).
     */
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getDouble("price"));
        product.setStock(rs.getInt("stock"));
        product.setImageUrl(rs.getString("image_url"));
        product.setActive(rs.getBoolean("is_active"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        return product;
    }

    /**
     * Admin paneli için tüm ürünleri (aktif/pasif) listeler.
     */
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY id DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            System.err.println("Tüm ürünler listelenirken hata: " + e.getMessage());
        }

        return products;
    }

    /**
     * Müşteri anasayfası için sadece aktif olan ürünleri getirir.
     */
    public List<Product> getActiveProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_active = true ORDER BY created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            System.err.println("Aktif ürünler listelenirken hata: " + e.getMessage());
        }

        return products;
    }

    /**
     * Belirli bir kategoriye ait aktif ürünleri filtreler.
     */
    public List<Product> getProductsByCategoryId(int categoryId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category_id = ? AND is_active = true ORDER BY name ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, categoryId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapResultSetToProduct(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Kategoriye göre ürünler filtrelenirken hata: " + e.getMessage());
        }

        return products;
    }

    /**
     * Ürün detay sayfası için ürün bilgilerini ID'ye göre getirir.
     */
    public Product getProductById(int id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        Product product = null;

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    product = mapResultSetToProduct(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Ürün getirilirken hata: " + e.getMessage());
        }

        return product;
    }

    /**
     * Yeni ürün ekleme işlemi (Admin için).
     */
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (category_id, name, description, price, stock, image_url, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if (product.getCategoryId() > 0) {
                pstmt.setInt(1, product.getCategoryId());
            } else {
                pstmt.setNull(1, java.sql.Types.INTEGER);
            }
            pstmt.setString(2, product.getName());
            pstmt.setString(3, product.getDescription());
            pstmt.setDouble(4, product.getPrice());
            pstmt.setInt(5, product.getStock());
            pstmt.setString(6, product.getImageUrl());
            pstmt.setBoolean(7, product.isActive());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Ürün eklenirken hata: " + e.getMessage());
            return false;
        }
    }

    /**
     * Ürün güncelleme işlemi (Admin için).
     */
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET category_id = ?, name = ?, description = ?, price = ?, stock = ?, image_url = ?, is_active = ? WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            if (product.getCategoryId() > 0) {
                pstmt.setInt(1, product.getCategoryId());
            } else {
                pstmt.setNull(1, java.sql.Types.INTEGER);
            }
            pstmt.setString(2, product.getName());
            pstmt.setString(3, product.getDescription());
            pstmt.setDouble(4, product.getPrice());
            pstmt.setInt(5, product.getStock());
            pstmt.setString(6, product.getImageUrl());
            pstmt.setBoolean(7, product.isActive());
            pstmt.setInt(8, product.getId());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Ürün güncellenirken hata: " + e.getMessage());
            return false;
        }
    }

    /**
     * Ürünü pasife çekme (Soft Delete).
     */
    public boolean deleteProduct(int id) {
        String sql = "UPDATE products SET is_active = false WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Ürün pasife alınırken hata: " + e.getMessage());
            return false;
        }
    }

    /**
     * Sipariş oluşturulduğunda satılan miktar kadar stoğu düşer.
     * Transaction işlemleri için bağlantı dışarıdan alınmamaktadır fakat bu basit senaryoda
     * ayrı bir sorgu olarak çalışacaktır (Eğer OrderDAO'daki transaction bloğuna dâhil edilecekse
     * bu metodun bir Connection alan overload'u da yazılabilir).
     */
    public boolean updateStock(int productId, int quantitySold) {
        String sql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, quantitySold);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantitySold); // Negatif stoğa düşmeyi önleyen basit bir güvenlik kontrolü

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;

        } catch (SQLException e) {
            System.err.println("Stok güncellenirken hata: " + e.getMessage());
            return false;
        }
    }
}
