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
            <div class="price-container">
                <p class="price">
                    <fmt:formatNumber value="${newProduct.finalPrice}" type="number" groupingUsed="true"/> đ
                </p>
                <c:if test="${newProduct.price != newProduct.finalPrice}">
                    <del class="original-price">
                        <fmt:formatNumber value="${newProduct.price}" type="number" groupingUsed="true"/> đ
                    </del>
                </c:if>
            </div>
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
            <div class="price-container">
                <p class="price">
                    <fmt:formatNumber value="${featuredProduct.finalPrice}" type="number" groupingUsed="true"/> đ
                </p>
                <c:if test="${featuredProduct.price != featuredProduct.finalPrice}">
                    <del class="original-price">
                        <fmt:formatNumber value="${featuredProduct.price}" type="number" groupingUsed="true"/> đ
                    </del>
                </c:if>
            </div>
            <div class="badge-new">Nổi Bật</div>
            <button type="button"
                    onclick="addToCart(${featuredProduct.id})" ${featuredProduct.current_stock == 0 ? "disabled" : ""}>
                THÊM VÀO GIỎ
            </button>
        </div>

        <div class="product-item featured-item">
            <img src="../images/thitTC1.png" alt="Thịt thăn heo nổi bật">
            <h3>${bestSellerProduct.name}</h3>
            <div class="price-container">
                <p class="price">
                    <fmt:formatNumber value="${bestSellerProduct.finalPrice}" type="number" groupingUsed="true"/> đ
                </p>
                <c:if test="${bestSellerProduct.price != bestSellerProduct.finalPrice}">
                    <del class="original-price">
                        <fmt:formatNumber value="${bestSellerProduct.price}" type="number" groupingUsed="true"/> đ
                    </del>
                </c:if>
            </div>
            <div class="badge-new">Bán Chạy</div>
            <button type="button"
                    onclick="addToCart(${bestSellerProduct.id})" ${bestSellerProduct.current_stock == 0 ? "disabled" : ""}>
                THÊM VÀO GIỎ
            </button>
        </div>

        <div class="product-item featured-item">
            <img src="../images/thitTC2.png" alt="Thịt đùi gà nổi bật">
            <h3>${bestDealProduct.name}</h3>
            <div class="price-container">
                <p class="price">
                    <fmt:formatNumber value="${bestDealProduct.finalPrice}" type="number" groupingUsed="true"/> đ
                </p>
                <c:if test="${bestDealProduct.price != bestDealProduct.finalPrice}">
                    <del class="original-price">
                        <fmt:formatNumber value="${bestDealProduct.price}" type="number" groupingUsed="true"/> đ
                    </del>
                </c:if>
            </div>
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
            <c:forEach var="item" items="${homeItems}">
                <div class="product-item">
                    <img src="${item.imageUrl}" alt="${item.name}">
                    <h3>${item.name}</h3>
                    <p class="price">
                        <fmt:formatNumber value="${item.finalPrice}" type="number"/> ₫
                    </p>
                    <button type="button"
                            onclick="addToCart(${item.id})" ${item.current_stock == 0 ? "disabled" : ""}>
                        THÊM VÀO GIỎ
                    </button>
                </div>
            </c:forEach>

            <div class="product-item view-all-item"
                 onclick="window.location.href='${pageContext.request.contextPath}/san-pham'">
                <i class="fa-solid fa-arrow-right" style="font-size: 50px; margin-bottom: 10px;"></i>
                <h3>Xem tất cả</h3>
                <p>Khám phá toàn bộ sản phẩm</p>
            </div>
        </div>

        <button class="arrow right" onclick="scrollToRight(this)">&#10095;</button>
    </div>
</section>
<script>
    function setupStickyMenu() {
        const menu = document.getElementById("home-menu");
        window.addEventListener("scroll", () => {
            if (window.scrollY > 100) {
                menu.classList.remove("home");
            } else {
                menu.classList.add("home");
            }
        });
    }

    document.addEventListener("DOMContentLoaded", () => {
        setupStickyMenu();
    });
</script>
