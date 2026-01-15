<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giới thiệu | Cleanmeat</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<!-- ================= GIỚI THIỆU CLEANMEAT ================= -->
<section class="hero">
    <div class="hero-text">
        <h1>
            Cleanmeat<br>
            Hân hạnh được đón tiếp bạn
        </h1>

        <p>
            Cleanmeat – nơi mỗi bữa ăn là một cam kết cho sức khỏe và sự an tâm.
            Chúng tôi hiểu rằng, đằng sau mỗi bữa ăn là tình yêu và sự chăm sóc dành cho gia đình.
            Vì thế, Cleanmeat luôn nỗ lực mang đến nguồn thịt tươi sạch, chất lượng cao.
        </p>
    </div>

    <div class="hero-image">
        <img
                src="https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRhfa1mB-mf2xr6UymKhtSKcgWWeQ24xWZ_IglQHT0q10Rblp5s"
                alt="Giới thiệu Cleanmeat">
    </div>
</section>

<!-- ================= TẦM NHÌN & SẢN PHẨM ================= -->
<section class="product-intro">
    <div class="product-container">
        <div class="product-image">
            <img
                    src="https://suckhoedoisong.qltns.mediacdn.vn/324455921873985536/2025/3/4/variousjpg-17410877772621749963682.jpg"
                    alt="Sản phẩm Cleanmeat">
        </div>

        <div class="product-text">
            <h2>Đa dạng về các loại thịt</h2>
            <p>
                Cleanmeat mang đến nhiều lựa chọn phong phú từ thịt heo, bò đến gà.
                Tất cả đều được kiểm định nghiêm ngặt, đảm bảo độ tươi ngon và an toàn cho sức khỏe.
                Chúng tôi mong muốn đồng hành cùng gia đình bạn trong từng bữa ăn.
            </p>
        </div>
    </div>
</section>

<!-- ================= QUY TRÌNH THỊT SẠCH ================= -->
<section class="quytrinh-section">
    <h2 class="title">Quy Trình Thịt Sạch Cleanmeat</h2>
    <p class="subtitle">
        Mỗi sản phẩm của Cleanmeat đều trải qua quy trình kiểm soát nghiêm ngặt
        nhằm mang đến giá trị dinh dưỡng và sự an tâm cho người tiêu dùng.
    </p>

    <div class="steps">
        <div class="step">
            <i class="fa-solid fa-seedling icon"></i>
            <h3>1. Chăn nuôi chuẩn sạch</h3>
            <p>
                Vật nuôi được chăm sóc trong môi trường tự nhiên,
                sử dụng thức ăn hữu cơ, không chất tăng trưởng hay kháng sinh độc hại.
            </p>
        </div>

        <div class="step">
            <i class="fa-solid fa-shield icon"></i>
            <h3>2. Kiểm định nghiêm ngặt</h3>
            <p>
                Toàn bộ quy trình giết mổ, bảo quản và vận chuyển
                đều được giám sát bởi đội ngũ chuyên gia.
            </p>
        </div>

        <div class="step">
            <i class="fa-solid fa-truck icon"></i>
            <h3>3. Đóng gói và giao tận tay</h3>
            <p>
                Sản phẩm được đóng gói bằng công nghệ hiện đại,
                đảm bảo giữ nguyên độ tươi ngon khi đến tay khách hàng.
            </p>
        </div>
    </div>
</section>

</body>
</html>
