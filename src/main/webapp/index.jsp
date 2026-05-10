<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-4">
    <!-- Modern Karşılama Alanı -->
    <div class="welcome-banner p-5 mb-5 text-center">
        <h1 class="fw-bold mb-3" style="color: #4a0e4e; letter-spacing: -1px;">Manistore'a Hoşgeldiniz</h1>
        <p class="fs-5 text-muted mb-0">Manifest grubunun en yeni ürünleri ve koleksiyonları şimdi tek bir tıkla kapında.</p>
    </div>

    <div class="row">
        <!-- Sol Menü (Kategoriler) -->
        <div class="col-md-3 mb-4">
            <div class="card p-3">
                <h5 class="fw-bold mb-3 ms-2" style="color: #4a0e4e;">Kategoriler</h5>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/home" 
                       class="list-group-item list-group-item-action fw-medium <c:if test='${empty selectedCategoryId}'>active</c:if>">
                        <i class="bi bi-grid"></i> Tüm Ürünler
                    </a>
                    <c:forEach var="category" items="${categories}">
                        <a href="${pageContext.request.contextPath}/home?categoryId=${category.id}" 
                           class="list-group-item list-group-item-action fw-medium <c:if test='${selectedCategoryId == category.id}'>active</c:if>">
                            ${category.name}
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <!-- Sağ Taraf (Ürün Listesi) -->
        <div class="col-md-9">
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <div class="col">
                                <div class="card h-100 shadow-sm border-0">
                                    <img src="${product.imageUrl}" class="card-img-top p-3" alt="${product.name}" onerror="this.src='https://via.placeholder.com/400x300?text=Görsel+Yok'">
                                    <div class="card-body">
                                        <h6 class="card-title text-truncate" title="${product.name}">${product.name}</h6>
                                        <p class="card-text fw-bold text-dark fs-5 mb-2">
                                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
                                        </p>
                                        
                                        <c:choose>
                                            <c:when test="${product.stock > 0}">
                                                <div class="small text-muted mb-3"><i class="bi bi-box-seam"></i> Stok: ${product.stock} adet</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="small text-danger mb-3 fw-bold">Tükendi</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="card-footer bg-transparent border-top-0 pb-3 pt-0">
                                        <div class="d-flex justify-content-between align-items-center gap-2">
                                            <a href="${pageContext.request.contextPath}/product?id=${product.id}" class="btn btn-outline-secondary btn-sm w-50 rounded-pill">Detay</a>
                                            
                                            <c:choose>
                                                <c:when test="${product.stock > 0}">
                                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="w-50">
                                                        <input type="hidden" name="action" value="add">
                                                        <input type="hidden" name="productId" value="${product.id}">
                                                        <input type="hidden" name="quantity" value="1">
                                                        <button type="submit" class="btn btn-primary btn-sm w-100 rounded-pill">Sepete Ekle</button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-danger btn-sm w-50 rounded-pill" disabled>Tükendi</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="alert alert-warning" role="alert"> <!-- Sarı Uyarı -->
                                Bu kategoride henüz ürün bulunmamaktadır.
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

</body>
</html>
