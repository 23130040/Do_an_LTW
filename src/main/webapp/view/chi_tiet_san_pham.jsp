<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section class="product-detail">

    <!-- ===== KHÔNG TÌM THẤY SẢN PHẨM ===== -->
    <c:if test="${empty baseItem}">
        <p class="not-found">Không tìm thấy sản phẩm.</p>
    </c:if>

    <!-- ===== CÓ SẢN PHẨM ===== -->
    <c:if test="${not empty baseItem}">

        <div class="product-wrapper">

            <!-- ================= ẢNH ================= -->
            <div class="product-image">
                <img id="main-img"
                     src="${pageContext.request.contextPath}/images/${baseItem.imageUrl}"
                     alt="${baseItem.name}"
                     onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'">
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

                        <!-- ================= 250g ================= -->
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
                                data-price="${v250 != null ? v250.price : ''}"
                            ${v250 == null || v250.current_stock == 0 ? 'disabled' : ''}>
                            250g
                        </button>

                        <!-- ================= 500g ================= -->
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
                                data-price="${v500 != null ? v500.price : ''}"
                            ${v500 == null || v500.current_stock == 0 ? 'disabled' : ''}>
                            500g
                        </button>

                        <!-- ================= 1kg ================= -->
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
                                data-price="${v1kg != null ? v1kg.price : ''}"
                            ${v1kg == null || v1kg.current_stock == 0 ? 'disabled' : ''}>
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

                    <button type="button"
                            class="btn-cart"
                            onclick="addToCart(${sp.id})"
                        ${sp.current_stock == 0 ? "disabled" : ""}>
                        <i class="fa fa-shopping-cart"></i>
                        THÊM VÀO GIỎ
                    </button>
                </form>
            </div>
        </div>

        <!-- ================= MÔ TẢ ================= -->
        <div class="product-description">
            <h2>Chi tiết sản phẩm</h2>
            <!-- Mô tả chi tiết -->
            <c:choose>
                <c:when test="${empty baseItem.long_description}">
                    <p class="long-desc">
                        Mô tả chi tiết sản phẩm đang được cập nhật.
                    </p>
                </c:when>
                <c:otherwise>
                    <p class="long-desc">
                            ${baseItem.long_description}
                    </p>
                </c:otherwise>
            </c:choose>

            <!-- Xuất xứ -->
            <c:choose>
            <c:when test="${origin != null}">
            <p class="origin">
                <strong>Xuất xứ:</strong> ${origin.name}
            </p>
            </c:when>
            <c:otherwise>
            <p class="origin">
                <strong>Xuất xứ:</strong> Đang cập nhật
            </p>
            </c:otherwise>
            </c:choose>
            <p><strong>Bảo quản:</strong> 0 – 4°C</p>
            <p><strong>Hạn sử dụng:</strong> 7 ngày kể từ ngày đóng gói</p>
            <p><strong>Đóng gói:</strong> Hút chân không đảm bảo vệ sinh an toàn thực phẩm</p>
        </div>

            <!-- ================= BÌNH LUẬN ================= -->
        <div class="product-comments">
            <h2>Bình luận</h2>

            <c:choose>
                <c:when test="${empty feedbackList}">
                    <p class="no-comment">Sản phẩm chưa có bình luận.</p>
                </c:when>

                <c:otherwise>
                    <c:forEach items="${feedbackList}" var="fb">

                        <div class="comment-item">

                            <div class="comment-header">
                                <div class="comment-user-date">
                                    <span class="comment-user">
                                        Người dùng ${fb.user.username}
                                    </span>
                                    <span class="comment-date">
                                            ${fb.created_at}
                                    </span>
                                </div>
                            </div>

                            <div class="comment-rating">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fa-solid fa-star
                               ${i <= fb.rating ? 'active' : ''}">
                                    </i>
                                </c:forEach>
                            </div>

                            <p class="comment-content">
                                    ${fb.comment}
                            </p>

                        </div>

                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </c:if>

    <div class="back-to-list">
        <a href="${pageContext.request.contextPath}/san-pham">
            ← Quay lại danh sách
        </a>
    </div>
</section>
    <!-- PHẦN CAM KẾT DỊCH VỤ -->
    <section class="features-section">
        <div class="features-container">
            <div class="feature-item">
                <i class="fa-solid fa-shield-halved"></i>
                <p>Sản phẩm an toàn</p>
            </div>
            <div class="feature-item">
                <i class="fa-solid fa-basket-shopping"></i>
                <p>Chất lượng cam kết</p>
            </div>
            <div class="feature-item">
                <i class="fa-solid fa-hand-holding-heart"></i>
                <p>Dịch vụ vượt trội</p>
            </div>
            <div class="feature-item">
                <i class="fa-solid fa-truck-fast"></i>
                <p>Giao hàng nhanh</p>
            </div>
        </div>
    </section>



