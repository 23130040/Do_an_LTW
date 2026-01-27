<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- ========== SAN PHAM PAGE ========== -->
<div class="san-pham-page">

    <div class="page-container">
        <section class="product-list-section">

            <!-- ================= SIDEBAR ================= -->
            <aside class="sidebar">
                <h3>Danh mục sản phẩm</h3>
                <ul>

                    <a href="${pageContext.request.contextPath}/san-pham">
                        <li class="${empty param.category ? 'active' : ''}">
                            TẤT CẢ
                        </li>
                    </a>

                    <a href="${pageContext.request.contextPath}/san-pham?category=heo">
                        <li class="${param.category == 'heo' ? 'active' : ''}">
                            THỊT HEO
                        </li>
                    </a>

                    <a href="${pageContext.request.contextPath}/san-pham?category=bo">
                        <li class="${param.category == 'bo' ? 'active' : ''}">
                            THỊT BÒ
                        </li>
                    </a>

                    <a href="${pageContext.request.contextPath}/san-pham?category=ga">
                        <li class="${param.category == 'ga' ? 'active' : ''}">
                            THỊT GÀ
                        </li>
                    </a>

                </ul>
            </aside>

            <!-- ================= NỘI DUNG BÊN PHẢI ================= -->
            <div class="product-wrapper">

                <!-- SORT -->
                <div class="sort-box">
                    <div class="sort-selected">
                        <c:choose>
                            <c:when test="${param.sort == 'price_asc'}">Giá tăng dần</c:when>
                            <c:when test="${param.sort == 'price_desc'}">Giá giảm dần</c:when>
                            <c:otherwise>Mặc định</c:otherwise>
                        </c:choose>
                    </div>

                    <ul class="sort-options">
                        <li data-sort="default">Mặc định</li>
                        <li data-sort="price_asc">Giá tăng dần</li>
                        <li data-sort="price_desc">Giá giảm dần</li>
                    </ul>
                </div>

                <!-- ================= DANH SÁCH SẢN PHẨM ================= -->
                <div class="product-list">

                    <c:forEach items="${items}" var="item">
                        <!-- chỉ lấy SKU gốc -->
                        <c:if test="${item.sku != null && item.sku.endsWith('1')}">

                            <div class="product-item ${item.current_stock == 0 ? 'out-of-stock' : ''}">

                                <a href="${pageContext.request.contextPath}/product?id=${item.id}"
                                   class="product-link">

                                    <c:if test="${item.discount > 0}">
                                        <div class="discount">-${item.discount}%</div>
                                    </c:if>

                                    <!-- ===== ẢNH ===== -->
                                    <img
                                            src="${pageContext.request.contextPath}/images/${item.imageUrl}"
                                            alt="${item.name}"
                                            onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'">

                                    <h3>${item.name}</h3>
                                </a>

                                <!-- ===== GIÁ ===== -->
                                <div class="price">
                                    <c:choose>
                                        <c:when test="${item.discount > 0}">
                                            <span class="new">
                                                <fmt:formatNumber
                                                        value="${item.price * (100 - item.discount) / 100}"
                                                        type="number"/> ₫
                                            </span>
                                            <span class="old">
                                                <fmt:formatNumber value="${item.price}" type="number"/> ₫
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="new">
                                                <fmt:formatNumber value="${item.price}" type="number"/> ₫
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- ===== ADD CART ===== -->
                                <form method="post">
                                    <input type="hidden" name="itemId" value="${item.id}">
                                    <button type="button"
                                            onclick="addToCart(${item.id})"
                                        ${item.current_stock == 0 ? "disabled" : ""}>
                                        THÊM VÀO GIỎ
                                    </button>
                                </form>

                            </div>

                        </c:if>
                    </c:forEach>

                    <c:if test="${empty items}">
                        <p style="padding:20px">Không có sản phẩm.</p>
                    </c:if>

                </div>

                <!-- ================= PHÂN TRANG ================= -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">

                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage - 1}">&laquo;</a>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <a href="?page=${p}"
                               class="${p == currentPage ? 'active' : ''}">
                                    ${p}
                            </a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="?page=${currentPage + 1}">&raquo;</a>
                        </c:if>

                    </div>
                </c:if>

            </div>
        </section>
    </div>
</div>
