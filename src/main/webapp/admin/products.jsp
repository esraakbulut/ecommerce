<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Ürün Yönetimi</h2>
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addModal">Yeni Ürün Ekle</button>
</div>

<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger">${sessionScope.errorMessage}</div>
    <c:remove var="errorMessage" scope="session" />
</c:if>

<div class="card shadow-sm border-0">
    <div class="card-body p-0">
        <table class="table table-striped table-hover mb-0">
            <thead class="table-dark">
                <tr>
                    <th>Görsel</th>
                    <th>ID</th>
                    <th>Ürün Adı</th>
                    <th>Fiyat</th>
                    <th>Stok</th>
                    <th>Durum</th>
                    <th>İşlemler</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="p" items="${products}">
                    <tr>
                        <td><img src="${p.imageUrl}" width="40" height="40" class="rounded object-fit-cover" onerror="this.src='https://via.placeholder.com/40'"></td>
                        <td class="align-middle">${p.id}</td>
                        <td class="align-middle">${p.name}</td>
                        <td class="align-middle"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₺"/></td>
                        <td class="align-middle">${p.stock}</td>
                        <td class="align-middle">
                            <c:choose>
                                <c:when test="${p.active}"><span class="badge bg-success">Aktif</span></c:when>
                                <c:otherwise><span class="badge bg-danger">Pasif</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="align-middle">
                            <form action="${pageContext.request.contextPath}/admin/products" method="post" class="d-inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${p.id}">
                                <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Bu ürünü pasife almak istiyor musunuz?');">Sil</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Ekleme Modalı -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <form action="${pageContext.request.contextPath}/admin/products" method="post" class="modal-content">
            <input type="hidden" name="action" value="add">
            <div class="modal-header">
                <h5 class="modal-title">Yeni Ürün Ekle</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label>Kategori</label>
                        <select name="categoryId" class="form-select" required>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Ürün Adı</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Fiyat (₺)</label>
                        <input type="number" step="0.01" name="price" class="form-control" min="0.01" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Stok Miktarı</label>
                        <input type="number" name="stock" class="form-control" min="0" required>
                    </div>
                    <div class="col-12 mb-3">
                        <label>Görsel URL</label>
                        <input type="text" name="imageUrl" class="form-control">
                    </div>
                    <div class="col-12 mb-3">
                        <label>Açıklama</label>
                        <textarea name="description" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="col-12">
                        <div class="form-check">
                            <input type="checkbox" name="isActive" class="form-check-input" id="pActive" checked>
                            <label class="form-check-label" for="pActive">Satışta (Aktif)</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                <button type="submit" class="btn btn-primary">Kaydet</button>
            </div>
        </form>
    </div>
</div>

        </div> <!-- /.col-md-10 (header.jsp'den gelen kapanış) -->
    </div> <!-- /.row -->
</div> <!-- /.container-fluid -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
