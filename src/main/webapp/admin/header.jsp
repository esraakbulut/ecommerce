<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yönetim Paneli</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-top: 70px; background-color: #f4f6f9; }
        .sidebar { min-height: calc(100vh - 70px); background-color: #343a40; }
        .sidebar a { color: #c2c7d0; padding: 15px; display: block; text-decoration: none; }
        .sidebar a:hover { background-color: #495057; color: #fff; }
    </style>
</head>
<body>

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
