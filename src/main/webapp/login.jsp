<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4">Giriş Yap</h3>

                    <c:if test="${not empty param.registered}">
                        <div class="alert alert-success">Kayıt başarılı! Şimdi giriş yapabilirsiniz.</div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label class="form-label">E-Posta Adresi</label>
                            <input type="email" name="email" class="form-control" required placeholder="ornek@mail.com">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Şifre</label>
                            <input type="password" name="password" class="form-control" required placeholder="Şifreniz">
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-2">Giriş Yap</button>
                    </form>
                    
                    <div class="text-center mt-3">
                        <small>Hesabınız yok mu? <a href="${pageContext.request.contextPath}/register">Kayıt Ol</a></small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
