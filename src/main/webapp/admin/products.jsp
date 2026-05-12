<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">Ürün Yönetimi</h2>
    <button class="btn btn-primary rounded-pill px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#addModal"><i class="bi bi-plus-circle me-1"></i> Yeni Ürün Ekle</button>
</div>

<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger border-0 rounded-3 small">${sessionScope.errorMessage}</div>
    <c:remove var="errorMessage" scope="session" />
</c:if>

<div class="card shadow-sm border-0 rounded-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead style="background-color: #fde8ed;">
                    <tr>
                        <th class="ps-4 text-muted font-weight-normal py-3">Görsel</th>
                        <th class="text-muted font-weight-normal py-3">ID</th>
                        <th class="text-muted font-weight-normal py-3">Ürün Adı</th>
                        <th class="text-muted font-weight-normal py-3">Fiyat</th>
                        <th class="text-muted font-weight-normal py-3">Stok</th>
                        <th class="text-muted font-weight-normal py-3">Durum</th>
                        <th class="pe-4 text-muted font-weight-normal py-3 text-end">İşlemler</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td class="ps-4"><img src="${p.imageUrl}" width="45" height="45" class="rounded-3 shadow-sm object-fit-cover" onerror="this.src='https://via.placeholder.com/45'"></td>
                            <td class="text-muted fw-bold">#${p.id}</td>
                            <td class="fw-medium text-dark">${p.name}</td>
                            <td class="fw-bold" style="color: #d63384;"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₺"/></td>
                            <td><span class="badge bg-light text-dark border px-2 py-1 rounded-3">${p.stock}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.active}"><span class="badge rounded-pill px-3" style="background-color: #20c997;">Aktif</span></c:when>
                                    <c:otherwise><span class="badge rounded-pill bg-danger px-3">Pasif</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td class="pe-4 text-end">
                                <form action="${pageContext.request.contextPath}/admin/products" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Bu ürünü pasife almak istiyor musunuz?');">Pasif Yap</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Ekleme Modalı -->
<div class="modal fade" id="addModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <form action="${pageContext.request.contextPath}/admin/products" method="post" class="modal-content border-0 rounded-4 shadow-lg">
            <input type="hidden" name="action" value="add">
            <div class="modal-header border-0 pb-0 mt-2 mx-2">
                <h5 class="modal-title fw-bold" style="color: #4a0e4e;">Yeni Ürün Ekle</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body px-4">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold text-secondary small">Kategori</label>
                        <select name="categoryId" class="form-select form-select-lg bg-light border-0 rounded-3" style="font-size: 1rem;" required>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold text-secondary small">Ürün Adı</label>
                        <input type="text" name="name" class="form-control form-control-lg bg-light border-0 rounded-3" style="font-size: 1rem;" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold text-secondary small">Fiyat (₺)</label>
                        <input type="number" step="0.01" name="price" class="form-control form-control-lg bg-light border-0 rounded-3" style="font-size: 1rem;" min="0.01" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold text-secondary small">Stok Miktarı</label>
                        <input type="number" name="stock" class="form-control form-control-lg bg-light border-0 rounded-3" style="font-size: 1rem;" min="0" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold text-secondary small">Görsel URL</label>
                        <input type="text" name="imageUrl" class="form-control form-control-lg bg-light border-0 rounded-3" style="font-size: 1rem;">
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold text-secondary small">Açıklama</label>
                        <textarea name="description" class="form-control bg-light border-0 rounded-3" rows="3"></textarea>
                    </div>
                    <div class="col-12 mt-4">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" role="switch" name="isActive" id="pActive" checked>
                            <label class="form-check-label fw-medium text-dark" for="pActive">Satışta (Aktif)</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 pt-0 mb-2 mx-2">
                <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">İptal</button>
                <button type="submit" class="btn btn-primary rounded-pill px-5 shadow-sm">Kaydet</button>
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
