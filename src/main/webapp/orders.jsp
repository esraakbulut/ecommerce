<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<<<<<<< HEAD
<div class="container mt-4">
    <h2 class="mb-4">Sipariş Geçmişim</h2>

    <c:if test="${not empty param.success}">
        <div class="alert alert-success">Siparişiniz başarıyla oluşturuldu! Bizi tercih ettiğiniz için teşekkür ederiz.</div>
=======
<div class="container mt-5 mb-5">
    <h2 class="mb-4 fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">📦 Sipariş Geçmişim</h2>

    <c:if test="${not empty param.success}">
        <div class="alert alert-success border-0 rounded-3 small shadow-sm">Siparişiniz başarıyla oluşturuldu! Bizi tercih ettiğiniz için teşekkür ederiz.</div>
>>>>>>> c9d587d (son rotuslar yapildi)
    </c:if>

    <c:choose>
        <c:when test="${not empty orders && orders.size() > 0}">
<<<<<<< HEAD
            <div class="card shadow-sm border-0">
                <div class="card-body p-0">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>Sipariş No</th>
                                <th>Tarih</th>
                                <th>Toplam Tutar</th>
                                <th>Durum</th>
                                <th>Detay</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td class="align-middle fw-bold">#${order.id}</td>
                                    <td class="align-middle">
                                        <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/>
                                    </td>
                                    <td class="align-middle">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                    </td>
                                    <td class="align-middle">
                                        <c:choose>
                                            <c:when test="${order.status == 'Beklemede'}">
                                                <span class="badge bg-warning text-dark">${order.status}</span>
                                            </c:when>
                                            <c:when test="${order.status == 'Hazırlanıyor'}">
                                                <span class="badge bg-info text-dark">${order.status}</span>
                                            </c:when>
                                            <c:when test="${order.status == 'Tamamlandı' || order.status == 'Kargoya Verildi'}">
                                                <span class="badge bg-success">${order.status}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">${order.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="align-middle">
                                        <a href="${pageContext.request.contextPath}/order?id=${order.id}" class="btn btn-sm btn-outline-primary">İncele</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
=======
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle">
                            <thead style="background-color: #fde8ed;">
                                <tr>
                                    <th class="ps-4 text-muted font-weight-normal py-3">Sipariş No</th>
                                    <th class="text-muted font-weight-normal py-3">Tarih</th>
                                    <th class="text-muted font-weight-normal py-3">Toplam Tutar</th>
                                    <th class="text-muted font-weight-normal py-3">Durum</th>
                                    <th class="pe-4 text-muted font-weight-normal py-3 text-end">Detay</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td class="ps-4 fw-bold" style="color: #4a0e4e;">#${order.id}</td>
                                        <td class="text-muted">
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm"/>
                                        </td>
                                        <td class="fw-bold" style="color: #d63384;">
                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'Beklemede'}">
                                                    <span class="badge rounded-pill bg-warning text-dark px-3">${order.status}</span>
                                                </c:when>
                                                <c:when test="${order.status == 'Hazırlanıyor'}">
                                                    <span class="badge rounded-pill bg-info text-dark px-3">${order.status}</span>
                                                </c:when>
                                                <c:when test="${order.status == 'Tamamlandı' || order.status == 'Kargoya Verildi'}">
                                                    <span class="badge rounded-pill px-3" style="background-color: #20c997;">${order.status}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge rounded-pill bg-secondary px-3">${order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="pe-4 text-end">
                                            <a href="${pageContext.request.contextPath}/order?id=${order.id}" class="btn btn-sm btn-outline-primary rounded-pill px-3">İncele</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
>>>>>>> c9d587d (son rotuslar yapildi)
                </div>
            </div>
        </c:when>
        <c:otherwise>
<<<<<<< HEAD
            <div class="alert alert-info">Henüz hiç siparişiniz bulunmamaktadır.</div>
=======
            <div class="text-center py-5 my-5">
                <div class="mb-4" style="font-size: 4rem; color: #fde8ed;">📦</div>
                <h3 class="fw-bold" style="color: #4a0e4e;">Henüz Siparişiniz Yok</h3>
                <p class="text-muted mb-4">Geçmiş siparişleriniz burada listelenecektir.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary rounded-pill px-4 py-2 shadow-sm">Alışverişe Başla</a>
            </div>
>>>>>>> c9d587d (son rotuslar yapildi)
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
