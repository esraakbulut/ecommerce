<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manistore</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        /* Modern ve Premium Estetik Teması */
        body { 
            padding-top: 85px; 
            background-color: #f8f9fa; /* Çok temiz açık gri */
            font-family: 'Inter', sans-serif;
            color: #333;
        }
        
        /* Cam Efektli (Glassmorphism) Navbar */
        .navbar {
            background-color: rgba(253, 232, 237, 0.85) !important; /* Yarı saydam açık pembe */
            backdrop-filter: blur(12px); /* Arkadaki içeriği hafif bulandırır */
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.5);
            box-shadow: 0 4px 20px rgba(214, 51, 132, 0.08); /* Çok yumuşak, geniş gölge */
            transition: all 0.3s ease;
        }

        .navbar-brand { 
            font-weight: 800; 
            font-size: 1.5rem;
            color: #d63384 !important;
            letter-spacing: -0.5px; /* Daha modern metin aralığı */
        }

        .nav-link {
            color: #4a0e4e !important;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .nav-link:hover {
            color: #d63384 !important;
        }

        /* Modern Kart ve Hover Animasyonları */
        .card {
            border: none;
            border-radius: 18px; /* Daha yumuşak köşeler */
            background: #ffffff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03); /* Çok hafif statik gölge */
            transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.3s ease; /* Pürüzsüz animasyon */
        }
        
        .card:hover {
            transform: translateY(-8px); /* Havalanma efekti */
            box-shadow: 0 15px 30px rgba(0,0,0,0.08); /* Derinleşen gölge */
        }
        
        .card-img-top { 
            height: 220px; 
            object-fit: cover; 
            border-radius: 18px 18px 0 0; 
        }

        /* Premium Buton Dokunuşları (Hareketsiz) */
        .btn {
            transition: box-shadow 0.3s ease, background 0.3s ease;
            font-weight: 600;
            letter-spacing: 0.3px;
        }
        
        .btn:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1); /* Sadece gölge değişsin, hareket etmesin */
        }

        .btn-primary {
            background: linear-gradient(135deg, #8a2be2, #6a0dad); /* Mor geçiş */
            border: none;
            color: white;
            box-shadow: 0 4px 12px rgba(106, 13, 173, 0.25);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #9370db, #8a2be2);
            box-shadow: 0 6px 18px rgba(106, 13, 173, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #20c997, #198754);
            border: none;
        }

        /* Kategori Menüsü (Hareketsiz) */
        .list-group-item {
            border: none;
            margin-bottom: 5px;
            border-radius: 8px !important;
            transition: background-color 0.2s ease, color 0.2s ease;
        }
        .list-group-item:hover {
            background-color: #fde8ed;
            color: #d63384;
        }
        .list-group-item.active {
            background-color: #d63384 !important;
            border: none;
        }
        
        /* Karşılama Alanı Özel Class */
        .welcome-banner {
            background: linear-gradient(135deg, #fde8ed 0%, #e2d9f3 100%);
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
            border: 1px solid rgba(255,255,255,0.6);
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Manistore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-2">
                    <a class="nav-link px-3" href="${pageContext.request.contextPath}/home">Anasayfa</a>
                </li>
                <li class="nav-item me-3">
                    <a class="nav-link px-3" href="${pageContext.request.contextPath}/cart">
                        Sepetim <span class="badge bg-warning text-dark rounded-pill ms-1">
                            <c:out value="${sessionScope.cart != null ? sessionScope.cart.size() : 0}" />
                        </span>
                    </a>
                </li>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                Hoşgeldin, ${sessionScope.loggedInUser.fullName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end border-0 shadow-sm rounded-3">
                                <li><a class="dropdown-item text-primary py-2" href="${pageContext.request.contextPath}/order">Siparişlerim</a></li>
                                <c:if test="${sessionScope.loggedInUser.role == 'admin'}">
                                    <li><a class="dropdown-item text-danger py-2" href="${pageContext.request.contextPath}/admin/dashboard">Admin Paneli</a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-secondary py-2" href="${pageContext.request.contextPath}/logout">Çıkış Yap</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="btn btn-outline-primary btn-sm rounded-pill px-4 me-2" href="${pageContext.request.contextPath}/login">Giriş Yap</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-success btn-sm rounded-pill px-4" href="${pageContext.request.contextPath}/register">Kayıt Ol</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
