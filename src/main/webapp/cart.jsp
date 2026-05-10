<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">Alışveriş Sepetim</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
            <div class="row">
                <div class="col-md-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-body p-0">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>Ürün</th>
                                        <th>Fiyat</th>
                                        <th width="150">Adet</th>
                                        <th>Toplam</th>
                                        <th>İşlem</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="cartTotal" value="0" />
                                    <c:forEach var="item" items="${sessionScope.cart}">
                                        <c:set var="cartTotal" value="${cartTotal + item.totalPrice}" />
                                        <tr>
                                            <td class="align-middle">
                                                <div class="d-flex align-items-center">
                                                    <img src="${item.product.imageUrl}" alt="product" width="50" height="50" class="me-3 rounded object-fit-cover" onerror="this.src='https://via.placeholder.com/50'">
                                                    <a href="${pageContext.request.contextPath}/product?id=${item.product.id}" class="text-decoration-none text-dark fw-bold">
                                                        ${item.product.name}
                                                    </a>
                                                </div>
                                            </td>
                                            <td class="align-middle">
                                                <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                            </td>
                                            <td class="align-middle">
                                                <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="productId" value="${item.product.id}">
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stock}" class="form-control form-control-sm me-1">
                                                    <button type="submit" class="btn btn-sm btn-outline-secondary" title="Güncelle">↻</button>
                                                </form>
                                            </td>
                                            <td class="align-middle fw-bold text-success">
                                                <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                            </td>
                                            <td class="align-middle">
                                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="productId" value="${item.product.id}">
                                                    <button type="submit" class="btn btn-sm btn-danger">Sil</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-body">
                            <h5 class="card-title mb-4">Sipariş Özeti</h5>
                            <div class="d-flex justify-content-between mb-3">
                                <span>Ara Toplam</span>
                                <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span>Kargo Tutarı</span>
                                <span>₺0,00</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between mb-4">
                                <span class="fw-bold fs-5">Genel Toplam</span>
                                <span class="fw-bold fs-5 text-success">
                                    <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                </span>
                            </div>
                            
                            <form action="${pageContext.request.contextPath}/order" method="post">
                                <button type="submit" class="btn btn-success btn-lg w-100">Siparişi Tamamla</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info text-center py-5">
                <h4>Sepetiniz şu anda boş.</h4>
                <p class="mb-4">Alışverişe başlamak için hemen ürünlerimize göz atın.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Alışverişe Başla</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
