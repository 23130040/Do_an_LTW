<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="banner">
    <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="Banner background" class="banner-img">
    <div class="gretting">
        <h1 id="greet-title">Chào Mừng Đến Với ${globalConfig.name}</h1>
        <p id="greet-desc">Vì sức khỏe, vì gia đình, và vì chính bạn. Chúng tôi mong mỗi bữa ăn đều là một niềm hạnh
            phúc</p>
    </div>
</div>
<section class="featured-product-section product-section">
    <h2 class="section-title"> SẢN PHẨM NỔI BẬT </h2>
    <div class="product-list">
        <div class="product-item featured-item">
            <img src="${pageContext.request.contextPath}/images/${newProduct.imageUrl}"
                 alt="${newProduct.name}">
            <h3>${newProduct.name}</h3>
            <p class="price">${newProduct.price} đ</p>
            <div class="badge-new">Sản phẩm mới</div>
            <button type="button"
                    onclick="addToCart(${newProduct.id})" ${newProduct.current_stock == 0 ? "disabled" : ""}>
                THÊM VÀO GIỎ
            </button>
        </div>

        <div class="product-item featured-item">
            <img src="${pageContext.request.contextPath}/images/${featuredProduct.imageUrl}"
                 alt="${featuredProduct.name}">
            <h3>${featuredProduct.name}</h3>
            <p class="price">${featuredProduct.price} đ</p>
            <div class="badge-new">Nổi Bật</div>
            <button type="button"
                    onclick="addToCart(${featuredProduct.id})" ${featuredProduct.current_stock == 0 ? "disabled" : ""}>
                THÊM VÀO GIỎ
            </button>
        </div>

        <div class="product-item featured-item">
            <img src="../images/thitTC1.png" alt="Thịt thăn heo nổi bật">
            <h3>${bestSellerProduct.name}</h3>
            <p class="price">${bestSellerProduct.price} đ</p>
            <div class="badge-new">Bán Chạy</div>
            <button type="button"
                    onclick="addToCart(${bestSellerProduct.id})" ${bestSellerProduct.current_stock == 0 ? "disabled" : ""}>
                THÊM VÀO GIỎ
            </button>
        </div>

        <div class="product-item featured-item">
            <img src="../images/thitTC2.png" alt="Thịt đùi gà nổi bật">
            <h3>${bestDealProduct.name}</h3>
            <p class="price">${bestDealProduct.price} đ</p>
            <div class="badge-new">Giá Tốt</div>
            <button type="button"
                    onclick="addToCart(${bestDealProduct.id})" ${bestDealProduct.current_stock == 0 ? "disabled" : ""}>
                THÊM VÀO GIỎ
            </button>
        </div>
    </div>
</section>

<!-- SẢN PHẨM CỦA CHÚNG TÔI -->
<section class="product-section">
    <h2 class="section-title">SẢN PHẨM CỦA CHÚNG TÔI</h2>
    <div class="product-carousel">
        <button class="arrow left" onclick="scrollToLeft(this)">&#10094;</button>

        <div class="product-list scrollable">
            <div class="product-item">
                <img src="../images/thitTC2.png" alt="Thịt đùi gà">
                <h3>Thịt đùi gà</h3>
                <p class="price">69.000 ₫ / KG</p>
                <button>THÊM VÀO GIỎ</button>
            </div>
            <div class="product-item">
                <img src="../images/thitTC1.png" alt="Thịt thăn heo">
                <h3>Thịt thăn heo</h3>
                <p class="price">89.000 ₫ / KG</p>
                <button>THÊM VÀO GIỎ</button>
            </div>
            <div class="product-item">
                <img src="../images/thitTC3.png" alt="Thịt bò tươi">
                <h3>Thịt bò tươi</h3>
                <p class="price">350.000 ₫ / KG</p>
                <button>THÊM VÀO GIỎ</button>
            </div>
            <div class="product-item">
                <img src="../images/thitTC4.png" alt="Thịt nọng heo">
                <h3>Thịt nọng heo</h3>
                <p class="price">330.000 ₫ / KG</p>
                <button>THÊM VÀO GIỎ</button>
            </div>
            <div class="product-item">
                <img src="../images/thitTC5.png" alt="Thịt ức gà">
                <h3>Thịt ức gà</h3>
                <p class="price">70.000 ₫ / KG</p>
                <button>THÊM VÀO GIỎ</button>
            </div>
            <div class="product-item view-all-item" onclick="window.location.href='${pageContext.request.contextPath}/san-pham'">
                <i class="fa-solid fa-arrow-right" style="font-size: 50px; margin-bottom: 10px;"></i>
                <h3>Xem tất cả</h3>
                <p>Khám phá toàn bộ sản phẩm</p>
            </div>
        </div>

        <button class="arrow right" onclick="scrollToRight(this)">&#10095;</button>
    </div>
</section>

