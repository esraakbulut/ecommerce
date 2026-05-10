<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Sipariş Detayı (#${order.id})</h2>
    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary">Geri Dön</a>
</div>

<div class="row">
    <div class="col-md-4 mb-4">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-dark text-white fw-bold">Sipariş Özeti</div>
            <div class="card-body">
                <p><strong>Müşteri ID:</strong> ${order.userId}</p>
                <p><strong>Tarih:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/></p>
                <p><strong>Toplam Tutar:</strong> <span class="text-success fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/></span></p>
                
                <hr>
                <form action="${pageContext.request.contextPath}/admin/orders" method="post">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="orderId" value="${order.id}">
                    <label class="form-label">Sipariş Durumu</label>
                    <select name="status" class="form-select mb-3">
                        <option value="Beklemede" <c:if test="${order.status == 'Beklemede'}">selected</c:if>>Beklemede</option>
                        <option value="Hazırlanıyor" <c:if test="${order.status == 'Hazırlanıyor'}">selected</c:if>>Hazırlanıyor</option>
                        <option value="Kargoya Verildi" <c:if test="${order.status == 'Kargoya Verildi'}">selected</c:if>>Kargoya Verildi</option>
                        <option value="Tamamlandı" <c:if test="${order.status == 'Tamamlandı'}">selected</c:if>>Tamamlandı</option>
                        <option value="İptal Edildi" <c:if test="${order.status == 'İptal Edildi'}">selected</c:if>>İptal Edildi</option>
                    </select>
                    <button type="submit" class="btn btn-primary w-100">Durumu Güncelle</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-dark text-white fw-bold">Sipariş Kalemleri</div>
            <div class="card-body p-0">
                <table class="table table-striped mb-0">
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
                                <td><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₺"/></td>
                                <td>${item.quantity}</td>
                                <td class="fw-bold"><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

        </div> <!-- /.col-md-10 (header.jsp'den gelen kapanış) -->
    </div> <!-- /.row -->
</div> <!-- /.container-fluid -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
