<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Sipariş Detayı (#${order.id})</h2>
        <a href="${pageContext.request.contextPath}/order" class="btn btn-outline-secondary">Siparişlerime Dön</a>
    </div>

    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-light fw-bold">Sipariş Bilgileri</div>
                <div class="card-body">
                    <p><strong>Tarih:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/></p>
                    <p><strong>Durum:</strong> <span class="badge bg-primary">${order.status}</span></p>
                    <p><strong>Genel Toplam:</strong> <span class="text-success fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></span></p>
                </div>
            </div>
        </div>

        <div class="col-md-8">
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
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
