<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-lg border-0" style="border-radius: 20px;">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <h3 class="fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">Giriş Yap</h3>
                        <p class="text-muted small">Manistore dünyasına hoşgeldin</p>
                    </div>

                    <c:if test="${not empty param.registered}">
                        <div class="alert alert-success border-0 rounded-3 small">Kayıt başarılı! Şimdi giriş yapabilirsiniz.</div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger border-0 rounded-3 small">${errorMessage}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-secondary small">E-Posta Adresi</label>
                            <input type="email" name="email" class="form-control form-control-lg bg-light border-0" style="border-radius: 12px; font-size: 1rem;" required placeholder="ornek@mail.com">
                        </div>
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-secondary small">Şifre</label>
                            <input type="password" name="password" class="form-control form-control-lg bg-light border-0" style="border-radius: 12px; font-size: 1rem;" required placeholder="••••••••">
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-3" style="border-radius: 12px; font-size: 1rem;">Giriş Yap</button>
                    </form>
                    
                    <div class="text-center mt-4">
                        <span class="text-muted small">Hesabınız yok mu?</span> 
                        <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none" style="color: #d63384;">Hemen Kayıt Ol</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
