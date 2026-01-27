<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="product-detail">

    <c:if test="${empty sp}">
        <p class="not-found">Không tìm thấy sản phẩm.</p>
    </c:if>

    <c:if test="${not empty sp}">
        <!-- ===== KHỐI TRÊN ===== -->
        <div class="product-wrapper">

            <!-- ẢNH -->
            <div class="product-image">
                <img src="${sp.imageUrl}" alt="${sp.name}">
            </div>

            <!-- THÔNG TIN -->
            <div class="product-info">
                <h1>${sp.name}</h1>

                <p class="meta">
                    SKU: ${sp.sku} |
                    Xuất xứ: ${sp.originName} |
                    Đơn vị: ${sp.unitName}
                </p>

                <!-- GIÁ (KHÔNG GIẢM GIÁ) -->
                <div class="price-box">
                    <span class="price">
                        <fmt:formatNumber value="${sp.price}" type="number"/>đ
                    </span>
                </div>

                <!-- MÔ TẢ NGẮN -->
                <p class="short-desc">
                    <c:choose>
                        <c:when test="${empty sp.short_description}">
                            Mô tả ngắn đang được cập nhật.
                        </c:when>
                        <c:otherwise>
                            ${sp.short_description}
                        </c:otherwise>
                    </c:choose>
                </p>

                <!-- GIỎ HÀNG -->
                <form action="${pageContext.request.contextPath}/chi-tiet-san-pham" method="post">
                    <input type="hidden" name="action" value="addCart">
                    <input type="hidden" name="itemId" value="${sp.id}">
                    <input type="hidden" name="quantity" value="1">

                    <button type="submit" class="btn-cart">
                        <i class="fa-solid fa-cart-shopping"></i>
                        Thêm vào giỏ hàng
                    </button>
                </form>
            </div>
        </div>

        <!-- ===== GALLERY (NẾU CÓ) ===== -->
        <c:if test="${not empty sp.images}">
            <div class="product-gallery">
                <div class="gallery-list">
                    <c:forEach var="img" items="${sp.images}">
                        <img src="${img}" alt="${sp.name}">
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- ===== MÔ TẢ CHI TIẾT ===== -->
        <div class="product-description">
            <h2>Chi tiết sản phẩm</h2>

            <c:choose>
                <c:when test="${empty sp.long_description}">
                    <p>Mô tả sản phẩm đang được cập nhật.</p>
                </c:when>
                <c:otherwise>
                    <p>${sp.long_description}</p>
                </c:otherwise>
            </c:choose>
        </div>

        <   <!-- ===== BÌNH LUẬN ===== -->
        <div class="product-comments">
            <h2>Bình luận</h2>
            <p class="no-comment">Chức năng bình luận sẽ được cập nhật sau.</p>
        </div>

    </c:if>

</section>
