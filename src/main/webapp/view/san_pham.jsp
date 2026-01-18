<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/san_pham.css">

<div class="page-container">
    <section class="product-list-section">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <h3>Danh mục sản phẩm</h3>
            <ul>
                <li class="${empty param.category ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/products">
                        TẤT CẢ
                    </a>
                </li>

                <li class="${param.category == 'heo' ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/products?category=heo">
                        THỊT HEO
                    </a>
                </li>

                <li class="${param.category == 'ga' ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/products?category=ga">
                        THỊT GÀ
                    </a>
                </li>

                <li class="${param.category == 'bo' ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/products?category=bo">
                        THỊT BÒ
                    </a>
                </li>
            </ul>
        </aside>

        <!-- BÊN PHẢI -->
        <div class="product-wrapper">

            <!-- SORT -->
            <div class="filter-top">
                <form method="get" action="${pageContext.request.contextPath}/products">
                    <input type="hidden" name="category" value="${param.category}"/>

                    <select name="sort" onchange="this.form.submit()">
                        <option value="">Mặc định</option>
                        <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>
                            Giá tăng dần
                        </option>
                        <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>
                            Giá giảm dần
                        </option>
                    </select>
                </form>
            </div>

            <!-- LIST -->
            <div class="product-list">
                <c:forEach items="${items}" var="item">

                    <div class="product-item ${item.current_stock == 0 ? 'out-of-stock' : ''}">

                        <a href="${pageContext.request.contextPath}/product?id=${item.id}"
                           class="product-link">

                            <c:if test="${item.discount > 0}">
                                <div class="discount">-${item.discount}%</div>
                            </c:if>

                            <img src="${pageContext.request.contextPath}/images/${item.imageUrl}"
                                 alt="${item.name}"/>

                            <h3>${item.name}</h3>
                        </a>

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

                        <button ${item.current_stock == 0 ? "disabled" : ""}>
                            THÊM VÀO GIỎ
                        </button>

                    </div>

                </c:forEach>

                <c:if test="${empty items}">
                    <p style="padding:20px">Không có sản phẩm.</p>
                </c:if>
            </div>

        </div>
    </section>
</div>
