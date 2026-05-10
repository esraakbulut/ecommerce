<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">Sipariş Geçmişim</h2>

    <c:if test="${not empty param.success}">
        <div class="alert alert-success">Siparişiniz başarıyla oluşturuldu! Bizi tercih ettiğiniz için teşekkür ederiz.</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty orders && orders.size() > 0}">
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
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">Henüz hiç siparişiniz bulunmamaktadır.</div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
