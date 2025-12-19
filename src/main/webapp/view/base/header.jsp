<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ===== HEADER ===== -->
<nav class="menubar">
    <div class="sixteen column">

        <!-- LOGO -->
        <div class="one-fifth column left">
            <img src="${pageContext.request.contextPath}/images/logoCleanmeat.png" alt="CleanMeat Logo">
        </div>

        <!-- MENU GIỮA -->
        <div class="three-fifths column center">
            <ul class="menu-center">
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/trang-chu">Trang chủ</a>
                </li>
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/sanpham">Sản phẩm</a>
                </li>
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/gioithieu">Giới thiệu</a>
                </li>
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/tintuc">Tin tức</a>
                </li>
                <li class="menuitem">
                    <a href="${pageContext.request.contextPath}/chinhsachdoitra">Chính sách đổi trả</a>
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
                    <i class="fa-solid fa-cart-shopping"></i>
                </li>

                <!-- USER -->
                <li class="menuitem-right user-menu-wrapper" id="user-setting">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/dangnhap" class="login-link">Đăng nhập</a>
                        </c:when>
                        <c:otherwise>
                            <div class="user">
                                <i class="fa-solid fa-user"></i>
                            </div>
                            <ul class="user-menu">
                                <li class="user-menuitem">
                                    <a href="${pageContext.request.contextPath}/taikhoan">Tài khoản của tôi</a>
                                </li>
                                <li class="user-menuitem">
                                    <a href="${pageContext.request.contextPath}/donhang">Đơn hàng của tôi</a>
                                </li>
                                <li class="user-menuitem">
                                    <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                                </li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </div>
</nav>
