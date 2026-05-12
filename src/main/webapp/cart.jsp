<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<<<<<<< HEAD
<div class="container mt-4">
    <h2 class="mb-4">Alışveriş Sepetim</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
=======
<div class="container mt-5 mb-5">
    <h2 class="mb-4 fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">🛍️ Alışveriş Sepetim</h2>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger border-0 rounded-3 small">${errorMessage}</div>
>>>>>>> c9d587d (son rotuslar yapildi)
    </c:if>

    <c:choose>
        <c:when test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
            <div class="row">
                <div class="col-md-8">
<<<<<<< HEAD
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
=======
                    <div class="card shadow-sm border-0 rounded-4 mb-4">
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0 align-middle">
                                    <thead style="background-color: #fde8ed;">
                                        <tr>
                                            <th class="ps-4 text-muted font-weight-normal py-3">Ürün</th>
                                            <th class="text-muted font-weight-normal py-3">Fiyat</th>
                                            <th width="150" class="text-muted font-weight-normal py-3">Adet</th>
                                            <th class="text-muted font-weight-normal py-3">Toplam</th>
                                            <th class="pe-4 text-muted font-weight-normal py-3"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="cartTotal" value="0" />
                                        <c:forEach var="item" items="${sessionScope.cart}">
                                            <c:set var="cartTotal" value="${cartTotal + item.totalPrice}" />
                                            <tr>
                                                <td class="ps-4 py-3">
                                                    <div class="d-flex align-items-center">
                                                        <img src="${item.product.imageUrl}" alt="product" width="60" height="60" class="me-3 rounded-3 shadow-sm object-fit-cover" onerror="this.src='https://via.placeholder.com/60'">
                                                        <a href="${pageContext.request.contextPath}/product?id=${item.product.id}" class="text-decoration-none fw-bold" style="color: #4a0e4e;">
                                                            ${item.product.name}
                                                        </a>
                                                    </div>
                                                </td>
                                                <td class="fw-medium text-dark">
                                                    <fmt:formatNumber value="${item.product.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                                </td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="d-flex align-items-center">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="productId" value="${item.product.id}">
                                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.stock}" class="form-control form-control-sm text-center border-0 bg-light me-2 rounded-pill" style="width: 60px;">
                                                        <button type="submit" class="btn btn-sm btn-outline-secondary rounded-circle" style="width: 30px; height: 30px; padding: 0;" title="Güncelle">↻</button>
                                                    </form>
                                                </td>
                                                <td class="fw-bold" style="color: #d63384;">
                                                    <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                                </td>
                                                <td class="pe-4 text-end">
                                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                                        <input type="hidden" name="action" value="remove">
                                                        <input type="hidden" name="productId" value="${item.product.id}">
                                                        <button type="submit" class="btn btn-sm btn-danger rounded-pill px-3">Sil</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
>>>>>>> c9d587d (son rotuslar yapildi)
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
<<<<<<< HEAD
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
=======
                    <div class="card shadow-sm border-0 rounded-4">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4" style="color: #4a0e4e;">Sipariş Özeti</h5>
                            <div class="d-flex justify-content-between mb-3 text-muted">
                                <span>Ara Toplam</span>
                                <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₺" maxFractionDigits="2"/></span>
                            </div>
                            <div class="d-flex justify-content-between mb-3 text-muted">
                                <span>Kargo Tutarı</span>
                                <span>₺0,00</span>
                            </div>
                            <hr class="text-muted opacity-25">
                            <div class="d-flex justify-content-between mb-4">
                                <span class="fw-bold fs-5" style="color: #4a0e4e;">Genel Toplam</span>
                                <span class="fw-bold fs-4" style="color: #d63384;">
>>>>>>> c9d587d (son rotuslar yapildi)
                                    <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                </span>
                            </div>
                            
                            <form action="${pageContext.request.contextPath}/order" method="post">
<<<<<<< HEAD
                                <button type="submit" class="btn btn-success btn-lg w-100">Siparişi Tamamla</button>
=======
                                <button type="submit" class="btn btn-primary btn-lg w-100 rounded-pill shadow-sm">Siparişi Tamamla</button>
>>>>>>> c9d587d (son rotuslar yapildi)
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
<<<<<<< HEAD
            <div class="alert alert-info text-center py-5">
                <h4>Sepetiniz şu anda boş.</h4>
                <p class="mb-4">Alışverişe başlamak için hemen ürünlerimize göz atın.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Alışverişe Başla</a>
=======
            <div class="text-center py-5 my-5">
                <div class="mb-4" style="font-size: 4rem; color: #fde8ed;">🛍️</div>
                <h3 class="fw-bold" style="color: #4a0e4e;">Sepetiniz şu anda boş</h3>
                <p class="text-muted mb-4">Manifest ürünlerini keşfetmek için hemen alışverişe başla.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary rounded-pill px-4 py-2 shadow-sm">Alışverişe Başla</a>
>>>>>>> c9d587d (son rotuslar yapildi)
            </div>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
