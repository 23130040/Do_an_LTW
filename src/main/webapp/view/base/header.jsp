<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!-- ===== HEADER ===== -->
<c:if test="${sessionScope.ROLE_ERROR}">
    <div class="modal fade" id="roleErrorModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-warning">
                    <h5 class="modal-title">Thông báo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Bạn không có quyền truy cập chức năng quản trị.
                </div>
            </div>
        </div>
    </div>
</c:if>
<nav class="menubar">
    <div class="sixteen column">

        <div class="one-fifth column left">
            <img src="${pageContext.request.contextPath}/images/logoCleanmeat.png" alt="CleanMeat Logo">
        </div>

        <div class="three-fifths column center">
            <ul class="menu-center">
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/trang-chu">Trang chủ</a>
                </li>
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/san-pham">Sản phẩm</a>
                </li>
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/gioi-thieu">Giới thiệu</a>
                </li>
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/tin-tuc">Tin tức</a>
                </li>
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/chinh-sach-doi-tra">Chính sách đổi trả</a>
                </li>
            </ul>
        </div>

        <!-- MENU PHẢI -->
        <div class="one-fifth column right">
            <ul class="menu-right">

                <!-- SEARCH -->
                <li class="menuitem-right" id="searchBar">
                    <span id="open-searchBar">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </span>
                    <input type="text" placeholder="Nhập từ khóa..." id="input-searchBar">
                    <span class="close-btn" id="close-searchBar">&times;</span>
                </li>

                <!-- CART -->
                <li class="menuitem-right" id="shopping-cart">
                    <a href="${pageContext.request.contextPath}/gio-hang" class="cart-link"><i
                            class="fa-solid fa-cart-shopping"></i>
                        <span id="count-item">
                            <c:choose>
                                <c:when test="${not empty sessionScope.cart}">
                                    ${sessionScope.cart.totalQuantity}
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </a>

                </li>

                <!-- USER -->
                <li class="menuitem-right user-menu-wrapper" id="user-setting">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/dang-nhap" class="login-link">Đăng nhập</a>
                        </c:when>
                        <c:otherwise>
                            <div class="user">
                                <i class="fa-solid fa-user"></i>
                            </div>
                            <ul class="user-menu">
                                <li class="user-menuitem">
                                    <a href="${pageContext.request.contextPath}/tai-khoan">Tài khoản của tôi</a>
                                </li>
                                <li class="user-menuitem">
                                    <a href="${pageContext.request.contextPath}/don-hang-cua-toi">Đơn hàng của tôi</a>
                                </li>
                                <li class="user-menuitem">
                                    <a href="${pageContext.request.contextPath}/dang-xuat?from=user">Đăng xuất</a>
                                </li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </div>
</nav>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        <%
            Boolean roleError = (Boolean) session.getAttribute("ROLE_ERROR");
            if (roleError != null && roleError) {
                session.removeAttribute("ROLE_ERROR");
        %>
        new bootstrap.Modal(
            document.getElementById("roleErrorModal")
        ).show();
        <% } %>
    });
</script>

