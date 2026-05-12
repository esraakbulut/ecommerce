<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">Kategori Yönetimi</h2>
    <button class="btn btn-primary rounded-pill px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#addModal"><i class="bi bi-plus-circle me-1"></i> Yeni Kategori Ekle</button>
</div>

<div class="card shadow-sm border-0 rounded-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead style="background-color: #fde8ed;">
                    <tr>
                        <th class="ps-4 text-muted font-weight-normal py-3">ID</th>
                        <th class="text-muted font-weight-normal py-3">Kategori Adı</th>
                        <th class="text-muted font-weight-normal py-3">Açıklama</th>
                        <th class="text-muted font-weight-normal py-3">Durum</th>
                        <th class="pe-4 text-muted font-weight-normal py-3 text-end">İşlemler</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cat" items="${categories}">
                        <tr>
                            <td class="ps-4 fw-bold text-muted">#${cat.id}</td>
                            <td class="fw-medium text-dark">${cat.name}</td>
                            <td class="text-muted">${cat.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${cat.active}">
                                        <span class="badge rounded-pill px-3" style="background-color: #20c997;">Aktif</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge rounded-pill bg-danger px-3">Pasif</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="pe-4 text-end">
                                <form action="${pageContext.request.contextPath}/admin/categories" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${cat.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Bu kategoriyi pasife almak istiyor musunuz?');">Pasif Yap</button>
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
    <div class="modal-dialog modal-dialog-centered">
        <form action="${pageContext.request.contextPath}/admin/categories" method="post" class="modal-content border-0 rounded-4 shadow-lg">
            <input type="hidden" name="action" value="add">
            <div class="modal-header border-0 pb-0 mt-2 mx-2">
                <h5 class="modal-title fw-bold" style="color: #4a0e4e;">Yeni Kategori Oluştur</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body px-4">
                <div class="mb-3">
                    <label class="form-label fw-semibold text-secondary small">Kategori Adı</label>
                    <input type="text" name="name" class="form-control form-control-lg bg-light border-0 rounded-3" style="font-size: 1rem;" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold text-secondary small">Açıklama</label>
                    <textarea name="description" class="form-control bg-light border-0 rounded-3" rows="3"></textarea>
                </div>
                <div class="form-check form-switch mt-4">
                    <input class="form-check-input" type="checkbox" role="switch" name="isActive" id="activeCheck" checked>
                    <label class="form-check-label fw-medium text-dark" for="activeCheck">Sitede aktif olarak gösterilsin mi?</label>
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
