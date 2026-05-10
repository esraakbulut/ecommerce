<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="container mt-5">
    <div class="row">
        <div class="col-md-5">
            <img src="${product.imageUrl}" class="img-fluid rounded shadow-sm w-100" alt="${product.name}" onerror="this.src='https://via.placeholder.com/600x600?text=Görsel+Yok'">
        </div>
        <div class="col-md-7">
            <h2 class="fw-bold">${product.name}</h2>
            <hr>
            <h3 class="text-success fw-bold">
                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺" maxFractionDigits="2"/>
            </h3>
            
            <div class="mt-4">
                <h5>Ürün Açıklaması</h5>
                <p class="text-muted" style="white-space: pre-wrap;">${product.description}</p>
            </div>
            
            <div class="mt-4">
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <div class="alert alert-info py-2" style="max-width: 200px;">
                            <strong>Stok Durumu:</strong> ${product.stock} Adet
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/cart" method="post" class="mt-3">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${product.id}">
                            
                            <div class="row align-items-center">
                                <div class="col-auto">
                                    <label class="col-form-label">Adet:</label>
                                </div>
                                <div class="col-auto">
                                    <input type="number" name="quantity" class="form-control" value="1" min="1" max="${product.stock}" required>
                                </div>
                                <div class="col-auto">
                                    <button type="submit" class="btn btn-primary btn-lg px-5">Sepete Ekle</button>
                                </div>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger d-inline-block">
                            <i class="bi bi-exclamation-triangle"></i> Bu ürün şu anda stoklarımızda bulunmamaktadır.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

</body>
</html>
