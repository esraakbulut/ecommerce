<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />

<<<<<<< HEAD
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4">Yeni Hesap Oluştur</h3>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
=======
<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg border-0" style="border-radius: 20px;">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <h3 class="fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">Yeni Hesap Oluştur</h3>
                        <p class="text-muted small">Manifest ailesine katıl!</p>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger border-0 rounded-3 small">${errorMessage}</div>
>>>>>>> c9d587d (son rotuslar yapildi)
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <div class="mb-3">
<<<<<<< HEAD
                            <label class="form-label">Ad Soyad</label>
                            <input type="text" name="fullName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">E-Posta Adresi</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Şifre</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Telefon</label>
                            <input type="text" name="phone" class="form-control">
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Adres</label>
                            <textarea name="address" class="form-control" rows="2"></textarea>
                        </div>
                        <button type="submit" class="btn btn-success w-100 py-2">Kayıt Ol</button>
                    </form>
                    
                    <div class="text-center mt-3">
                        <small>Zaten hesabınız var mı? <a href="${pageContext.request.contextPath}/login">Giriş Yap</a></small>
=======
                            <label class="form-label fw-semibold text-secondary small">Ad Soyad</label>
                            <input type="text" name="fullName" class="form-control form-control-lg bg-light border-0" style="border-radius: 12px; font-size: 1rem;" required>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold text-secondary small">E-Posta Adresi</label>
                                <input type="email" name="email" class="form-control form-control-lg bg-light border-0" style="border-radius: 12px; font-size: 1rem;" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold text-secondary small">Telefon</label>
                                <input type="text" name="phone" class="form-control form-control-lg bg-light border-0" style="border-radius: 12px; font-size: 1rem;">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">Şifre</label>
                            <input type="password" name="password" class="form-control form-control-lg bg-light border-0" style="border-radius: 12px; font-size: 1rem;" required placeholder="••••••••">
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary small">Adres</label>
                            <textarea name="address" class="form-control bg-light border-0" style="border-radius: 12px; font-size: 1rem;" rows="2"></textarea>
                        </div>
                        <button type="submit" class="btn btn-success w-100 py-3" style="border-radius: 12px; font-size: 1rem;">Aramıza Katıl</button>
                    </form>
                    
                    <div class="text-center mt-4">
                        <span class="text-muted small">Zaten hesabınız var mı?</span> 
                        <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none" style="color: #d63384;">Giriş Yap</a>
>>>>>>> c9d587d (son rotuslar yapildi)
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
