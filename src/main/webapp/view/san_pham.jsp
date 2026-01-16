<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- ================= BANNER ================= -->
<div class="banner">
    <img src="${pageContext.request.contextPath}/images/bannersp.jpg"
         alt="Banner background"
         class="banner-img">

    <div class="gretting">
        <h1 id="greet-title">
            Chào Mừng Đến Với ${globalConfig.name}
        </h1>

        <p id="greet-desc">
            Vì sức khỏe, vì gia đình, và vì chính bạn.
            Chúng tôi mong mỗi bữa ăn đều là một niềm hạnh phúc
        </p>
    </div>
</div>
<!-- ================= FLASH SALE ================= -->
<section class="flash-sale">
    <div class="flash-header">
        <h2><i class="fas fa-fire"></i> Flash Sale</h2>
    </div>

    <div class="flash-products">
        <c:forEach items="${flashItems}" var="item">
            <div class="flash-item">
                <div class="discount">-${item.discount}%</div>

                <a href="product?id=${item.id}">
                    <img src="${item.imageUrl}">
                    <p class="title">${item.name}</p>
                </a>

                <p class="price">
                    <fmt:formatNumber value="${item.finalPrice}" type="number"/>đ
                    <span class="old">
                        <fmt:formatNumber value="${item.price}" type="number"/>đ
                    </span>
                </p>

                <button>THÊM VÀO GIỎ</button>
            </div>
        </c:forEach>
    </div>
</section>

<!-- ================= DANH MỤC ================= -->
<div class="category-header">
    <h2 class="section-title">DANH MỤC SẢN PHẨM</h2>

    <div class="right-controls">
        <div class="category-buttons">
            <button class="category active" data-category="heo">Thịt heo</button>
            <button class="category" data-category="ga">Thịt gà</button>
            <button class="category" data-category="bo">Thịt bò</button>
        </div>

        <div class="custom-select">
            <div class="selected">Mặc định</div>
            <ul class="select-list">
                <li data-value="default">Mặc định</li>
                <li data-value="up">Giá tăng dần</li>
                <li data-value="down">Giá giảm dần</li>
            </ul>
        </div>

        <select id="sortSelect" style="display:none;">
            <option value="default">Mặc định</option>
            <option value="up">Giá tăng dần</option>
            <option value="down">Giá giảm dần</option>
        </select>
    </div>
</div>

<!-- ================= SẢN PHẨM ================= -->
<div class="product-list">
    <c:forEach items="${items}" var="item">

        <div class="product-item"
             data-category="${item.category_id == 1 ? 'heo' : item.category_id == 2 ? 'ga' : 'bo'}">

            <a href="product?id=${item.id}">
                <img src="${item.imageUrl}">
                <h3>${item.name}</h3>
            </a>

            <p class="price">
                <fmt:formatNumber value="${item.price}" type="number"/> ₫ / KG
            </p>

            <button>THÊM VÀO GIỎ</button>
        </div>

    </c:forEach>
</div>

<div class="view-all">
    <button id="viewAllBtn">Xem tất cả</button>
</div>
