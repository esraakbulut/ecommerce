<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
    <title>Yönetim Paneli</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-top: 70px; background-color: #f4f6f9; }
        .sidebar { min-height: calc(100vh - 70px); background-color: #343a40; }
        .sidebar a { color: #c2c7d0; padding: 15px; display: block; text-decoration: none; }
        .sidebar a:hover { background-color: #495057; color: #fff; }
=======
    <title>Manistore Admin Paneli</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        /* Manistore Admin Teması */
        body { 
            padding-top: 70px; 
            background-color: #f8f9fa; 
            font-family: 'Inter', sans-serif;
            color: #333;
        }
        
        /* Navbar - Koyu Mor */
        .navbar {
            background-color: #4a0e4e !important;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-bottom: 3px solid #d63384; /* Pembe vurgu */
        }
        .navbar-brand { 
            font-weight: 800; 
            color: #fde8ed !important; 
            letter-spacing: -0.5px;
        }
        .nav-link { color: #fde8ed !important; font-weight: 500; transition: color 0.3s ease; }
        .nav-link:hover { color: #ffb3ba !important; }

        /* Sidebar - Soft Lila Arkaplan */
        .sidebar { 
            min-height: calc(100vh - 70px); 
            background-color: #fde8ed; 
            box-shadow: inset -1px 0 0 rgba(0,0,0,.05);
        }
        .sidebar a { 
            color: #4a0e4e; 
            padding: 15px 20px; 
            display: block; 
            text-decoration: none; 
            font-weight: 600;
            border-bottom: 1px solid rgba(214, 51, 132, 0.1);
            transition: all 0.2s ease;
        }
        .sidebar a:hover { 
            background-color: #4a0e4e; 
            color: #fff; 
            padding-left: 25px; /* Hafif sağa kayma efekti */
        }

        /* Ortak Element Sınıfları */
        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }
        .card-header {
            background-color: white;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            border-radius: 16px 16px 0 0 !important;
            font-weight: 700;
            color: #4a0e4e;
        }
        
        .btn { font-weight: 600; transition: all 0.3s ease; border-radius: 8px; }
        .btn-primary { background: linear-gradient(135deg, #8a2be2, #6a0dad); border: none; color: white; }
        .btn-primary:hover { background: linear-gradient(135deg, #9370db, #8a2be2); box-shadow: 0 4px 10px rgba(106, 13, 173, 0.2); }
        .btn-success { background: linear-gradient(135deg, #20c997, #198754); border: none; }
        .btn-danger { background: linear-gradient(135deg, #d63384, #dc3545); border: none; }
        .btn-warning { background-color: #ffc107; color: #4a0e4e; border: none; font-weight: 700; }
        
        .table { vertical-align: middle; }
        .table thead th { border-bottom: 2px solid #d63384; color: #4a0e4e; font-weight: 700; }
>>>>>>> c9d587d (son rotuslar yapildi)
    </style>
</head>
<body>

<<<<<<< HEAD
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">Yönetim Paneli</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">Siteye Dön</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Çıkış Yap</a>
=======
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">Manistore Yönetim</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="bi bi-shop"></i> Siteye Dön</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Çıkış Yap</a>
>>>>>>> c9d587d (son rotuslar yapildi)
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar p-0">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Özet (Dashboard)</a>
            <a href="${pageContext.request.contextPath}/admin/categories">Kategori Yönetimi</a>
            <a href="${pageContext.request.contextPath}/admin/products">Ürün Yönetimi</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Sipariş Yönetimi</a>
            <a href="${pageContext.request.contextPath}/admin/users">Kullanıcılar</a>
        </div>
        
        <!-- Main Content (Diğer sayfalarda açılacak kısım) -->
        <div class="col-md-10 p-4">
