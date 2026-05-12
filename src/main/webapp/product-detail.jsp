<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-5 mb-5">
    <div class="row align-items-center">
        <div class="col-md-5 mb-4 mb-md-0">
            <div class="position-relative">
                <img src="${product.imageUrl}" class="img-fluid rounded-4 shadow-sm w-100 object-fit-cover" style="max-height: 500px;" alt="${product.name}" onerror="this.src='https://via.placeholder.com/600x600?text=Görsel+Yok'">
            </div>
        </div>
        <div class="col-md-7 ps-md-5">
            <h2 class="fw-bold mb-1" style="color: #4a0e4e; letter-spacing: -1px; font-size: 2.5rem;">${product.name}</h2>
            <p class="text-muted fs-5 mb-0"><i class="bi bi-tags me-1"></i> ${category.name}</p>
            <hr class="opacity-10 my-4">
            <h3 class="fw-bold mb-4" style="color: #d63384; font-size: 2rem;">
                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
            </h3>
            
            <div class="mb-4">
                <h5 class="fw-bold" style="color: #4a0e4e;">Ürün Açıklaması</h5>
                <p class="text-muted" style="white-space: pre-wrap; line-height: 1.8;">${product.description}</p>
            </div>
            
            <div class="mt-5">
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <div class="d-flex align-items-center mb-3">
                            <span class="badge rounded-pill" style="background-color: #e2d9f3; color: #4a0e4e; padding: 8px 15px;">
                                <i class="bi bi-box-seam me-1"></i> Stokta var (${product.stock} Adet)
                            </span>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-3 bg-white p-4 rounded-4 shadow-sm">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.id}">
                            
                            <div class="row align-items-center g-3">
                                <div class="col-auto">
                                    <label class="col-form-label fw-bold text-muted">Adet:</label>
                                </div>
                                <div class="col-auto">
                                    <input type="number" name="quantity" class="form-control form-control-lg bg-light border-0 text-center rounded-pill" style="width: 80px;" value="1" min="1" max="${product.stock}" required>
                                </div>
                                <div class="col">
                                    <button type="submit" class="btn btn-primary btn-lg w-100 rounded-pill shadow-sm">Sepete Ekle</button>
                                </div>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert border-0 rounded-4 p-4 text-center" style="background-color: #fde8ed; color: #d63384;">
                            <h5 class="fw-bold mb-0"><i class="bi bi-exclamation-triangle"></i> Bu ürün şu anda stoklarımızda bulunmamaktadır.</h5>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

</body>
</html>
