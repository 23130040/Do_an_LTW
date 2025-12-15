<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header>
    <div class="sixteen column">
        <div class="one-fifth column left">
            <img src="${pageContext.request.contextPath}/images/logoCleanmeat.png" alt="logo">
        </div>

        <div class="three-fifths column center">
            <ul class="menu-center">
                <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li><a href="#">Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/gioithieu">Giới thiệu</a></li>
                <li><a href="#">Tin tức</a></li>
                <li><a href="#">Chính sách đổi trả</a></li>
            </ul>
        </div>

        <div class="one-fifth column right">
            <ul class="menu-right">
                <li>
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" placeholder="Nhập từ khóa...">
                </li>
                <li>
                    <i class="fa-solid fa-cart-shopping"></i>
                </li>
                <li>
                    <a href="#">Đăng nhập</a>
                </li>
            </ul>
        </div>
    </div>
</header>
