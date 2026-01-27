<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section class="product-detail">

    <c:if test="${empty baseItem}">
        <p class="not-found">Không tìm thấy sản phẩm.</p>
    </c:if>

    <c:if test="${not empty baseItem}">

        <div class="product-wrapper">

            <!-- ================= ẢNH ================= -->
            <div class="product-image">
                <img id="main-img"
                     src="${baseItem.imageUrl}"
                     alt="${baseItem.name}">
            </div>

            <!-- ================= THÔNG TIN ================= -->
            <div class="product-info">

                <h1 class="product-title">${baseItem.name}</h1>

                <!-- RATING -->
                <div class="product-rating">
                    <div class="stars">
                        <c:forEach begin="1" end="5">
                            <i class="fa-solid fa-star"></i>
                        </c:forEach>
                    </div>
                    <span class="rating-text">
                ${rating.avgRating} | ${rating.totalRating} đánh giá
            </span>
                </div>

                <!-- GIÁ -->
                <div class="price-box">
            <span class="price" id="product-price">
                <fmt:formatNumber value="${sp.price}" type="number"/>đ
            </span>
                </div>

                <!-- ================= KHỐI LƯỢNG ================= -->
                <div class="option-row">
                    <span class="label">Khối lượng:</span>

                    <div class="option-list">

                        <!-- 250g -->
                        <c:set var="v250" value="${null}" />
                        <c:forEach items="${variantList}" var="v">
                            <c:if test="${fn:endsWith(v.sku, '01')}">
                                <c:set var="v250" value="${v}" />
                            </c:if>
                        </c:forEach>

                        <button type="button"
                                class="option
                ${v250 == null || v250.current_stock == 0 ? 'disabled' : ''}
                ${v250 != null && v250.id == sp.id ? 'active' : ''}"
                                data-item-id="${v250 != null ? v250.id : ''}"
                                data-price="${v250 != null ? v250.price : ''}">
                            250g
                        </button>

                        <!-- 500g -->
                        <c:set var="v500" value="${null}" />
                        <c:forEach items="${variantList}" var="v">
                            <c:if test="${fn:endsWith(v.sku, '02')}">
                                <c:set var="v500" value="${v}" />
                            </c:if>
                        </c:forEach>

                        <button type="button"
                                class="option
                ${v500 == null || v500.current_stock == 0 ? 'disabled' : ''}
                ${v500 != null && v500.id == sp.id ? 'active' : ''}"
                                data-item-id="${v500 != null ? v500.id : ''}"
                                data-price="${v500 != null ? v500.price : ''}">
                            500g
                        </button>

                        <!-- 1kg -->
                        <c:set var="v1kg" value="${null}" />
                        <c:forEach items="${variantList}" var="v">
                            <c:if test="${fn:endsWith(v.sku, '03')}">
                                <c:set var="v1kg" value="${v}" />
                            </c:if>
                        </c:forEach>

                        <button type="button"
                                class="option
                ${v1kg == null || v1kg.current_stock == 0 ? 'disabled' : ''}
                ${v1kg != null && v1kg.id == sp.id ? 'active' : ''}"
                                data-item-id="${v1kg != null ? v1kg.id : ''}"
                                data-price="${v1kg != null ? v1kg.price : ''}">
                            1kg
                        </button>

                    </div>
                </div>
                <!-- ===== SỐ LƯỢNG ===== -->
                <div class="option-row">
                    <span class="label">Số lượng:</span>
                    <div class="quantity-box">
                        <button type="button" class="qty-minus">-</button>
                        <input type="text" id="qty-input" value="1">
                        <button type="button" class="qty-plus">+</button>
                    </div>
                </div>
                <!-- ================= GIỎ HÀNG ================= -->
                <form action="${pageContext.request.contextPath}/chi-tiet-san-pham" method="post">
                    <input type="hidden" name="action" value="addCart">
                    <input type="hidden" name="itemId" id="cart-item-id" value="${sp.id}">
                    <input type="hidden" name="quantity" id="cart-qty" value="1">

                    <button type="submit" class="btn-cart">
                        <i class="fa-solid fa-cart-shopping"></i>
                        Thêm vào giỏ hàng
                    </button>
                </form>

            </div>
        </div>

        <!-- ================= MÔ TẢ ================= -->
        <div class="product-description">
            <h2>Chi tiết sản phẩm</h2>
            <p>
                <c:choose>
                    <c:when test="${empty baseItem.long_description}">
                        Mô tả sản phẩm đang được cập nhật.
                    </c:when>
                    <c:otherwise>
                        ${baseItem.long_description}
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

        <!-- ================= BÌNH LUẬN ================= -->
        <div class="product-comments">
            <h2>Bình luận</h2>
            <p class="no-comment">Chức năng bình luận sẽ được cập nhật sau.</p>
        </div>

    </c:if>

</section>
