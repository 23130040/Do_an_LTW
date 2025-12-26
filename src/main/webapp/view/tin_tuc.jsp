<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ===== PHẦN TIN TỨC ===== -->
<section class="tin-tuc-layout">

    <!-- CỘT TRÁI: DANH SÁCH TIN -->
    <section class="tin-tuc-container">

        <!-- ===== TRANG 1 ===== -->
        <div class="tin-tuc-grid page-content" data-page="1">
            <div class="tin-item">
                <img src="https://i1-giadinh.vnecdn.net/2025/09/25/Thit-luoc-1-vnexpress-17587905-2958-3007-1758790776.jpg">
                <div class="tin-content">
                    <h3>Làm sao biết thịt luộc đã chín?</h3>
                    <div class="tin-meta">
                        <span><i class="fa-regular fa-calendar"></i> 25/9/2025</span>
                        <span><i class="fa-regular fa-eye"></i> 3 lượt xem</span>
                    </div>
                    <p>Một số người nội trợ có mẹo kiểm tra bằng cách cắm đũa xuyên vào phần dày nhất,
                        nếu không có nước đỏ hồng rỉ ra là thịt đã chín.</p>
                    <a href="chitiettintuc.jsp" class="tin-link">
                        Xem thêm <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>
            </div>

            <div class="tin-item">
                <img src="https://i1-vnexpress.vnecdn.net/2023/02/09/a-thit-dong-vat-5153-1675915186.jpg">
                <div class="tin-content">
                    <h3>Xe tải chở gần 6 tấn thịt hôi thối</h3>
                    <div class="tin-meta">
                        <span><i class="fa-regular fa-calendar"></i> 9/2/2023</span>
                        <span><i class="fa-regular fa-eye"></i> 1 lượt xem</span>
                    </div>
                    <p>Xe tải chở gần 6 tấn thịt bốc mùi, không giấy tờ kiểm dịch
                        đang trên đường từ Hà Nội sang Lào thì bị phát hiện.</p>
                    <a href="chitiettintuc.jsp" class="tin-link">
                        Xem thêm <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- ===== TRANG 2 ===== -->
        <div class="tin-tuc-grid page-content" data-page="2" style="display:none;">
            <div class="tin-item">
                <img src="https://i1-kinhdoanh.vnecdn.net/2025/11/08/2022-03-28T233711Z-1609630567-9659-6275-1762614764.jpg">
                <div class="tin-content">
                    <h3>Giá thịt bò ở Mỹ ngày càng đắt đỏ</h3>
                    <div class="tin-meta">
                        <span><i class="fa-regular fa-calendar"></i> 9/11/2025</span>
                        <span><i class="fa-regular fa-eye"></i> 5 lượt xem</span>
                    </div>
                    <p>Tranh cãi nổ ra khi giá thịt bò tại Mỹ tăng cao
                        do nguồn cung bị siết chặt.</p>
                    <a href="chitiettintuc.jsp" class="tin-link">
                        Xem thêm <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </div>

    </section>

    <!-- ===== CỘT PHẢI: TIN MỚI ===== -->
    <aside class="tin-moi">
        <h2>Bài viết mới nhất</h2>

        <div class="tin-moi-item">
            <img src="https://i1-kinhdoanh.vnecdn.net/2025/11/08/2022-03-28T233711Z-1609630567-9659-6275-1762614764.jpg">
            <div>
                <a href="chitiettintuc.jsp">Giá thịt bò ở Mỹ ngày càng đắt đỏ</a>
                <p><i class="fa-regular fa-calendar"></i> 9/11/2025</p>
            </div>
        </div>

        <div class="tin-moi-item">
            <img src="https://image.plo.vn/w850/Uploaded/2025/ymzmf/2025_10_24/thit-ga-5892-1825.png.webp">
            <div>
                <a href="chitiettintuc.jsp">Lợi ích ít biết của thịt gà</a>
                <p><i class="fa-regular fa-calendar"></i> 06/11/2025</p>
            </div>
        </div>
    </aside>

</section>

<!-- ===== PHÂN TRANG ===== -->
<div class="pagination">
    <a class="prev"><i class="fa-solid fa-chevron-left"></i></a>
    <a class="page active" data-page="1">1</a>
    <a class="page" data-page="2">2</a>
    <a class="next"><i class="fa-solid fa-chevron-right"></i></a>
</div>
