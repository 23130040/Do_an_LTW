<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- MAIN -->
<main>
    <section class="product-list-section">

        <!-- ===== SIDEBAR DANH MỤC ===== -->
        <aside class="sidebar">
            <h3>Danh mục sản phẩm</h3>
            <ul>
                <li class="category active" data-category="all">TẤT CẢ</li>
                <li class="category" data-category="heo">THỊT HEO</li>
                <li class="category" data-category="ga">THỊT GÀ</li>
                <li class="category" data-category="bo">THỊT BÒ</li>
            </ul>
        </aside>

        <!-- ===== DANH SÁCH + SORT ===== -->
        <div class="product-wrapper">

            <!-- SORT -->
            <div class="filter-top">
                <div class="custom-select">
                    <div class="selected" data-value="default">Mặc định</div>
                    <ul class="select-list">
                        <li data-value="default">Mặc định</li>
                        <li data-value="up">Giá tăng dần</li>
                        <li data-value="down">Giá giảm dần</li>
                    </ul>
                </div>
            </div>

            <!-- ===== DANH SÁCH SẢN PHẨM ===== -->
            <div class="product-list">

                <c:forEach items="${items}" var="item">

                    <!-- xác định category -->
                    <c:set var="cat"
                           value="${item.category_id == 1 ? 'heo' : (item.category_id == 2 ? 'ga' : 'bo')}" />

                    <!-- CARD SẢN PHẨM -->
                    <div class="product-item ${item.current_stock == 0 ? 'out-of-stock' : ''}"
                         data-category="${cat}">

                        <!-- HẾT HÀNG -->
                        <c:if test="${item.current_stock == 0}">
                            <div class="stock-label">HẾT HÀNG</div>
                        </c:if>

                        <!-- GIẢM GIÁ -->
                        <c:if test="${item.discount > 0}">
                            <div class="discount">-${item.discount}%</div>
                        </c:if>

                        <a href="${pageContext.request.contextPath}/product?id=${item.id}">

                            <!-- ẢNH -->
                            <img src="${pageContext.request.contextPath}/images/${item.imageUrl}"
                                 alt="${item.name}">

                            <!-- TÊN -->
                            <h3>${item.name}</h3>

                        </a>

                        <!-- GIÁ -->
                        <div class="price">
                            <c:choose>
                                <c:when test="${item.discount > 0}">
                                    <span class="new">
                                        <fmt:formatNumber
                                                value="${item.price * (100 - item.discount) / 100}"
                                                type="number"/> ₫ / KG
                                    </span>
                                    <span class="old">
                                        <fmt:formatNumber value="${item.price}" type="number"/> ₫
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="new">
                                        <fmt:formatNumber value="${item.price}" type="number"/> ₫ / KG
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- NÚT -->
                        <button type="button"
                            ${item.current_stock == 0 ? 'disabled' : ''}>
                            THÊM VÀO GIỎ
                        </button>

                    </div>

                </c:forEach>

            </div>
        </div>
    </section>
</main>
