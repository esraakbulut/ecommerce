<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<h2 class="mb-4">Sipariş Yönetimi</h2>

<div class="card shadow-sm border-0">
    <div class="card-body p-0">
        <table class="table table-striped table-hover mb-0">
            <thead class="table-dark">
                <tr>
                    <th>Sipariş No</th>
                    <th>Müşteri</th>
                    <th>Tarih</th>
                    <th>Tutar</th>
                    <th>Durum</th>
                    <th>İşlemler</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td class="align-middle fw-bold">#${order.id}</td>
                        <td class="align-middle">${order.user.fullName}</td>
                        <td class="align-middle"><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/></td>
                        <td class="align-middle fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/></td>
                        <td class="align-middle">
                            <!-- Durum Güncelleme Formu -->
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="d-flex">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="orderId" value="${order.id}">
                                <select name="status" class="form-select form-select-sm me-2" style="width: 140px;">
                                    <option value="Beklemede" <c:if test="${order.status == 'Beklemede'}">selected</c:if>>Beklemede</option>
                                    <option value="Hazırlanıyor" <c:if test="${order.status == 'Hazırlanıyor'}">selected</c:if>>Hazırlanıyor</option>
                                    <option value="Kargoya Verildi" <c:if test="${order.status == 'Kargoya Verildi'}">selected</c:if>>Kargoya Verildi</option>
                                    <option value="Tamamlandı" <c:if test="${order.status == 'Tamamlandı'}">selected</c:if>>Tamamlandı</option>
                                    <option value="İptal Edildi" <c:if test="${order.status == 'İptal Edildi'}">selected</c:if>>İptal Edildi</option>
                                </select>
                                <button type="submit" class="btn btn-sm btn-primary">Güncelle</button>
                            </form>
                        </td>
                        <td class="align-middle">
                            <a href="${pageContext.request.contextPath}/admin/orders?id=${order.id}" class="btn btn-sm btn-outline-info">Detay</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

        </div> <!-- /.col-md-10 (header.jsp'den gelen kapanış) -->
    </div> <!-- /.row -->
</div> <!-- /.container-fluid -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
