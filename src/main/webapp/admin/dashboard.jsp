<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />

<h2 class="mb-4 fw-bold" style="color: #4a0e4e; letter-spacing: -0.5px;">Yönetim Paneli Özeti</h2>

<div class="row row-cols-1 row-cols-md-5 g-4">
    <div class="col">
        <div class="card text-white shadow-sm border-0 rounded-4" style="background: linear-gradient(135deg, #8a2be2, #6a0dad);">
            <div class="card-body p-4">
                <h5 class="card-title opacity-75">Toplam Ürün</h5>
                <h2 class="mb-0 fw-bold display-5">${totalProducts}</h2>
            </div>
        </div>
    </div>
    
    <div class="col">
        <div class="card shadow-sm border-0 rounded-4" style="background-color: #fde8ed; color: #4a0e4e;">
            <div class="card-body p-4">
                <h5 class="card-title opacity-75">Kategoriler</h5>
                <h2 class="mb-0 fw-bold display-5">${totalCategories}</h2>
            </div>
        </div>
    </div>
    
    <div class="col">
        <div class="card text-white shadow-sm border-0 rounded-4" style="background: linear-gradient(135deg, #d63384, #dc3545);">
            <div class="card-body p-4">
                <h5 class="card-title opacity-75">Siparişler</h5>
                <h2 class="mb-0 fw-bold display-5">${totalOrders}</h2>
            </div>
        </div>
    </div>
    
    <div class="col">
        <div class="card shadow-sm border-0 rounded-4" style="background-color: #ffc107; color: #fff;">
            <div class="card-body p-4">
                <h5 class="card-title opacity-75">Bekleyen Sipariş</h5>
                <h2 class="mb-0 fw-bold display-5">${pendingOrders}</h2>
            </div>
        </div>
    </div>
    
    <div class="col">
        <div class="card text-white shadow-sm border-0 rounded-4" style="background: linear-gradient(135deg, #20c997, #198754);">
            <div class="card-body p-4">
                <h5 class="card-title opacity-75">Kayıtlı Kullanıcı</h5>
                <h2 class="mb-0 fw-bold display-5">${totalUsers}</h2>
            </div>
        </div>
    </div>
</div>

<div class="mt-5">
    <div class="alert border-0 rounded-4 p-4" style="background-color: #fcf8fa; border-left: 5px solid #d63384 !important; box-shadow: 0 4px 15px rgba(0,0,0,0.02);">
        <h5 class="fw-bold mb-1" style="color: #4a0e4e;">Hoşgeldiniz!</h5>
        <span class="text-muted">Sol taraftaki menüyü kullanarak mağazanızı yönetebilirsiniz.</span>
    </div>
</div>

        </div> <!-- /.col-md-10 (header.jsp'den gelen kapanış) -->
    </div> <!-- /.row -->
</div> <!-- /.container-fluid -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
