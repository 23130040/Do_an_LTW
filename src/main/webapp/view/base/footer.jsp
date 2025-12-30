<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer>
    <div class="footer-container">
        <div class="footer-col about-us">
            <img src="${pageContext.request.contextPath}./images/logoCleanmeat.png" alt="Logo">
            <p>${globalConfig.name} - Nguồn thịt tươi sạch, đảm bảo an toàn và chất lượng cho mọi gia đình Việt.</p>
            <div class="social-icons">
                <a href="${globalConfig.facebook}"><i class="fab fa-facebook-f"></i></a>
                <a href="${globalConfig.instagram}"><i class="fab fa-instagram"></i></a>
            </div>
        </div>

        <div class="footer-col quick-links">
            <h4>Liên kết nhanh</h4>
            <ul>
                <li><a href="#">Trang chủ</a></li>
                <li><a href="#">Sản phẩm</a></li>
                <li><a href="${pageContext.request.contextPath}/gioithieu">Giới thiệu</a></li>
                <li><a href="#">Tin tức</a></li>
                <li><a href="#">Chính sách đổi trả</a></li>
            </ul>
        </div>

        <div class="footer-col contact-info">
            <h4>Liên hệ chúng tôi</h4>
            <p><i class="fa-solid fa-map-location-dot"></i> Địa chỉ: ${globalConfig.address}</p>
            <p><i class="fa-solid fa-phone"></i> Hotline: ${globalConfig.hotline}</p>
            <p><i class="fa-solid fa-envelope"></i> Email: ${globalConfig.email}</p>
            <p><i class="fa-solid fa-clock"></i> <strong>Giờ mở cửa:</strong> T2 - CN (7:00 - 21:00)</p>
        </div>
    </div>

    <div class="footer-bottom">
        © 2025 CleanMeat
    </div>
</footer>
