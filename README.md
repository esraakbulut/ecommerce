# 💖 Manistore - Java E-Commerce Portal

**Manistore**, "Manifest" kız grubunun resmi ürünlerinin (albüm, tişört, kupa vb.) satıldığı, üniversite projesi veya portfolyo amacı taşıyan dinamik bir e-ticaret uygulamasıdır. Proje, güncel frameworkler (Spring, Hibernate vb.) kullanılmadan, tamamen "saf" Java teknolojileriyle **MVC (Model-View-Controller)** mimarisine uygun olarak sıfırdan geliştirilmiştir.

## 🚀 Kullanılan Teknolojiler

- **Backend:** Java 17+, Java Servlets, JSP (JavaServer Pages), JSTL
- **Veritabanı:** PostgreSQL, JDBC (Java Database Connectivity)
- **Frontend:** HTML5, CSS3, Bootstrap 5
- **Sunucu:** Apache Tomcat 9
- **Mimari:** MVC (Model, DAO, Controller, View katmanları)

## ✨ Temel Özellikler

- **Müşteri (User) İşlemleri:**
  - Kayıt olma ve giriş yapma (Session tabanlı yetkilendirme)
  - Kategorilere göre ürün filtreleme
  - Sepete ürün ekleme, çıkarma ve sepeti güncelleme
  - Sipariş oluşturma ve geçmiş siparişleri görüntüleme
- **Admin (Yönetici) İşlemleri:**
  - Kategori ekleme, düzenleme ve silme
  - Ürün ekleme, düzenleme, stok güncelleme ve silme (Soft delete)
  - Tüm siparişleri görüntüleme ve durumlarını yönetme
- **Sistem:**
  - Çakışmaları önlemek için Güvenli Sipariş Yönetimi (Transaction Rollback)
  - Modern, sade ve estetik (Glassmorphism detaylı) kullanıcı arayüzü

---

## 🛠️ Kurulum ve Çalıştırma Kılavuzu

Projeyi kendi bilgisayarınızda çalıştırmak için aşağıdaki adımları sırasıyla izleyin.

### 1. Veritabanı (PostgreSQL) Kurulumu
1. Bilgisayarınızda PostgreSQL yüklü olmalıdır. pgAdmin veya DBeaver üzerinden PostgreSQL'e bağlanın.
2. PostgreSQL üzerinde **`ecommerce_db`** adında yeni bir boş veritabanı oluşturun *(Kodda veritabanı adı bu şekilde tanımlıdır)*.
3. Proje klasöründeki `src/main/resources/schema.sql` dosyasını açın.
4. Bu SQL dosyasındaki tüm kodları kopyalayıp oluşturduğunuz `ecommerce_db` veritabanı üzerinde çalıştırın. Bu işlem gerekli tüm tabloları (`users`, `categories`, `products` vb.) otomatik olarak oluşturacaktır.

### 2. Veritabanı Bağlantı Ayarları
GitHub'a yüklenen kodda veritabanı bağlantı ayarları (`DBUtil.java` içerisinde) varsayılan olarak şu şekildedir:
- **Veritabanı Adı:** `ecommerce_db`
- **Kullanıcı Adı:** `postgres`
- **Şifre:** `1234`

Eğer sizin bilgisayarınızdaki PostgreSQL şifresi `1234` **değilse**, projeyi bir IDE'de (IntelliJ vb.) açıp `src/main/java/com/ecommerce/utils/DBUtil.java` dosyasındaki `PASSWORD` değerini kendi veritabanı şifrenizle değiştirmelisiniz.

### 3. Kütüphane (JAR) Dosyalarının Tanıtılması
Projenin çalışması için gerekli olan 2 kütüphane dosyası (**PostgreSQL JDBC Driver** ve **JSTL API**) zaten projenin içindeki **`src/main/webapp/WEB-INF/lib`** klasöründe hazır olarak bulunmaktadır. Yeniden internetten indirmenize gerek yoktur.
*Eğer IDE'niz (örn: IntelliJ) kodları derlerken bu kütüphaneleri otomatik görmezse, `Project Structure -> Modules -> Dependencies` kısmından bu `lib` klasörünün içindeki `.jar` dosyalarını projeye dahil (Add) etmeniz yeterlidir.*

### 4. Sunucu (Apache Tomcat) Ayarları
1. Apache Tomcat 9 sunucusunu bilgisayarınıza kurun.
2. IDE'niz üzerinden projeye Tomcat Server tanımlayın (Örn: IntelliJ için `Smart Tomcat` eklentisi).
3. Tomcat ayarlarında "Deployment Directory" (veya "Document Base") kısmını projenin içindeki `src/main/webapp` klasörü olarak seçin.
4. Context Path kısmına `/ecommerce` yazın.

### 5. Projeyi Başlatma
1. IDE üzerinden Tomcat sunucusunu `Run` veya `Debug` moduyla başlatın.
2. Sunucu hatasız ayağa kalktıktan sonra tarayıcınızı açın ve şu adrese gidin:
   👉 `http://localhost:8080/ecommerce/home`

---

## 👥 Admin Yetkisi Verme
Uygulamada bir kullanıcının admin olabilmesi için veritabanından yetki verilmesi gerekir:
1. Siteden normal bir şekilde kayıt olun.
2. PostgreSQL veritabanına gidin ve `users` tablosunu açın.
3. Kendi kullanıcınızın satırını bulun ve `role` sütunundaki `user` değerini `admin` olarak değiştirip kaydedin.
4. Çıkış yapıp tekrar giriş yaptığınızda menüde **Admin Paneli** butonunu göreceksiniz!

---
*Geliştirici Notu: Bu proje sıfırdan saf Java teknolojileri ile inşa edilmiştir. Sürükle-bırak veya hazır CMS sistemleri kullanılmamıştır.*
