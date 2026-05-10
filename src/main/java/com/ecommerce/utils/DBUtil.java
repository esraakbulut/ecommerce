package com.ecommerce.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    // Veritabanı URL, Kullanıcı Adı ve Şifre (PostgreSQL)
    private static final String URL = "jdbc:postgresql://localhost:5432/ecommerce_db";
    private static final String USER = "postgres";
    private static final String PASSWORD = "admin"; // Burayı kendi PostgreSQL şifrenizle değiştirin
    
    // JDBC Sürücüsü
    private static final String DRIVER = "org.postgresql.Driver";

    static {
        try {
            // Sürücüyü bir kez yüklüyoruz
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            System.err.println("JDBC Sürücüsü bulunamadı: " + e.getMessage());
        }
    }

    /**
     * Veritabanı bağlantısı döndürür.
     * @return Connection
     * @throws SQLException
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    /**
     * Bağlantıyı kapatır. (Opsiyonel yardımcı metod)
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Bağlantı kapatılırken hata: " + e.getMessage());
            }
        }
    }
}
