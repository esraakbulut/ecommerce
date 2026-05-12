<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<<<<<<< HEAD
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Sipariş Detayı (#${order.id})</h2>
        <a href="${pageContext.request.contextPath}/order" class="btn btn-outline-secondary">Siparişlerime Dön</a>
=======
<div class="container mt-5 mb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">📄 Sipariş Detayı <span class="text-muted fs-5">(#${order.id})</span></h2>
        <a href="${pageContext.request.contextPath}/order" class="btn btn-outline-secondary rounded-pill px-4">Siparişlerime Dön</a>
>>>>>>> c9d587d (son rotuslar yapildi)
    </div>

    <div class="row">
        <div class="col-md-4 mb-4">
<<<<<<< HEAD
            <div class="card shadow-sm border-0">
                <div class="card-header bg-light fw-bold">Sipariş Bilgileri</div>
                <div class="card-body">
                    <p><strong>Tarih:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/></p>
                    <p><strong>Durum:</strong> <span class="badge bg-primary">${order.status}</span></p>
                    <p><strong>Genel Toplam:</strong> <span class="text-success fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></span></p>
=======
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-transparent border-0 pt-4 pb-0 fw-bold" style="color: #4a0e4e; font-size: 1.1rem;">Sipariş Bilgileri</div>
                <div class="card-body">
                    <p class="mb-2"><strong class="text-muted">Tarih:</strong> <br><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/></p>
                    <p class="mb-3"><strong class="text-muted">Durum:</strong> <br>
                        <span class="badge rounded-pill bg-primary px-3 mt-1" style="background-color: #d63384 !important;">${order.status}</span>
                    </p>
                    <hr class="opacity-25">
                    <p class="mb-0"><strong class="text-muted">Genel Toplam:</strong> <br>
                        <span class="fs-4 fw-bold" style="color: #d63384;"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></span>
                    </p>
>>>>>>> c9d587d (son rotuslar yapildi)
                </div>
            </div>
        </div>

        <div class="col-md-8">
<<<<<<< HEAD
            <div class="card shadow-sm border-0">
                <div class="card-header bg-light fw-bold">Satın Alınan Ürünler</div>
                <div class="card-body p-0">
                    <table class="table mb-0">
                        <thead>
                            <tr>
                                <th>Ürün ID</th>
                                <th>Birim Fiyat</th>
                                <th>Adet</th>
                                <th>Ara Toplam</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${order.orderItems}">
                                <tr>
                                    <td>#${item.productId}</td>
                                    <td><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></td>
                                    <td>${item.quantity}</td>
                                    <td class="fw-bold"><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
=======
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table mb-0 align-middle table-hover">
                            <thead style="background-color: #fde8ed;">
                                <tr>
                                    <th class="ps-4 text-muted font-weight-normal py-3">Ürün ID</th>
                                    <th class="text-muted font-weight-normal py-3">Birim Fiyat</th>
                                    <th class="text-muted font-weight-normal py-3">Adet</th>
                                    <th class="pe-4 text-muted font-weight-normal py-3 text-end">Ara Toplam</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.orderItems}">
                                    <tr>
                                        <td class="ps-4 text-muted">#${item.productId}</td>
                                        <td class="fw-medium text-dark"><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></td>
                                        <td><span class="badge bg-light text-dark border px-2 py-1 rounded-3">${item.quantity}</span></td>
                                        <td class="pe-4 fw-bold text-end" style="color: #4a0e4e;"><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
>>>>>>> c9d587d (son rotuslar yapildi)
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
