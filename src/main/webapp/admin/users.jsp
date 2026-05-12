<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="header.jsp" />

<<<<<<< HEAD
<h2 class="mb-4">Kayıtlı Kullanıcılar</h2>

<div class="card shadow-sm border-0">
    <div class="card-body p-0">
        <table class="table table-striped table-hover mb-0">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Ad Soyad</th>
                    <th>E-Posta</th>
                    <th>Telefon</th>
                    <th>Rol</th>
                    <th>Kayıt Tarihi</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td class="fw-bold">${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.phone != null ? user.phone : '-'}</td>
                        <td>
                            <c:choose>
                                <c:when test="${user.role == 'admin'}">
                                    <span class="badge bg-danger">Yönetici</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Müşteri</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${user.createdAt}" pattern="dd.MM.yyyy"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
=======
<h2 class="mb-4 fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">Kayıtlı Kullanıcılar</h2>

<div class="card shadow-sm border-0 rounded-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0 align-middle">
                <thead style="background-color: #fde8ed;">
                    <tr>
                        <th class="ps-4 text-muted font-weight-normal py-3">ID</th>
                        <th class="text-muted font-weight-normal py-3">Ad Soyad</th>
                        <th class="text-muted font-weight-normal py-3">E-Posta</th>
                        <th class="text-muted font-weight-normal py-3">Telefon</th>
                        <th class="text-muted font-weight-normal py-3">Rol</th>
                        <th class="pe-4 text-muted font-weight-normal py-3 text-end">Kayıt Tarihi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td class="ps-4 text-muted fw-bold">#${user.id}</td>
                            <td class="fw-bold text-dark">${user.fullName}</td>
                            <td>${user.email}</td>
                            <td class="text-muted">${user.phone != null ? user.phone : '-'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.role == 'admin'}">
                                        <span class="badge rounded-pill px-3" style="background-color: #d63384;">Yönetici</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge rounded-pill bg-secondary px-3">Müşteri</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="pe-4 text-muted text-end"><fmt:formatDate value="${user.createdAt}" pattern="dd.MM.yyyy"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
>>>>>>> c9d587d (son rotuslar yapildi)
    </div>
</div>

        </div> <!-- /.col-md-10 (header.jsp'den gelen kapanış) -->
    </div> <!-- /.row -->
</div> <!-- /.container-fluid -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
