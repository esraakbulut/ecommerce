<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />

<h2 class="mb-4">Yönetim Paneli Özeti</h2>

<div class="row g-4">
    <div class="col-md-3">
        <div class="card bg-primary text-white shadow">
            <div class="card-body">
                <h5 class="card-title">Toplam Ürün</h5>
                <h2 class="mb-0">${totalProducts}</h2>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card bg-success text-white shadow">
            <div class="card-body">
                <h5 class="card-title">Kategoriler</h5>
                <h2 class="mb-0">${totalCategories}</h2>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card bg-warning text-dark shadow">
            <div class="card-body">
                <h5 class="card-title">Siparişler</h5>
                <h2 class="mb-0">${totalOrders}</h2>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card bg-danger text-white shadow">
            <div class="card-body">
                <h5 class="card-title">Kayıtlı Kullanıcı</h5>
                <h2 class="mb-0">${totalUsers}</h2>
            </div>
        </div>
    </div>
</div>

<div class="mt-5">
    <div class="alert alert-info">
        <strong>Hoşgeldiniz!</strong> Sol taraftaki menüyü kullanarak mağazanızı yönetebilirsiniz.
    </div>
</div>

        </div> <!-- /.col-md-10 (header.jsp'den gelen kapanış) -->
    </div> <!-- /.row -->
</div> <!-- /.container-fluid -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
