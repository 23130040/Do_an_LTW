<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<main>
    <div class="product-container">

        <!-- BÊN TRÁI: Hình ảnh sản phẩm -->
        <div class="product-images">
            <img id="main-img" src="https://bizweb.dktcdn.net/100/021/951/products/nam-bo-uc-hifood-55x50-2.jpg?v=1674041433870" class="main-image">

            <div class="thumbnail-list">
                <img src="https://bizweb.dktcdn.net/100/021/951/products/nam-bo-uc-hifood-55x50-2.jpg?v=1674041433870"
                     class="thumb active" onclick="changeImage(this)">
                <img src="https://bizweb.dktcdn.net/thumb/1024x1024/100/522/252/products/nac-mong-jpg.png?v=1726452916157"
                     class="thumb" onclick="changeImage(this)">
                <img src="https://amp.thucphamsachhd.com/uploads/files/2023/06/19/BOU0007-PD01562-WEB_Nac-Dui-Trong-Bo-Uc-Nguyen-Khoi.png"
                     class="thumb" onclick="changeImage(this)">
                <img src="https://bizweb.dktcdn.net/100/522/252/products/nam-bo-uc-dl.png?v=1724469537923"
                     class="thumb" onclick="changeImage(this)">
                <img src="https://product.hstatic.net/1000282430/product/290014257000_21ea4d79c1404fb4977599c29c2017f8_grande.gif"
                     class="thumb" onclick="changeImage(this)">
            </div>
        </div>

        <!-- BÊN PHẢI: Thông tin sản phẩm -->
        <div class="product-info">
            <h2 class="title">Nạm bò Úc</h2>

            <div class="rating">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star-half-stroke"></i>
                <span>4.9 | 1.660 đánh giá</span>
            </div>

            <div class="price-box">
                <span class="new-price">199.000₫</span>
                <span class="old-price">249.000₫</span>
                <span class="discount">-20%</span>
            </div>

            <div class="section"><p class="label">Khối lượng:</p>
                <div class="options">
                    <button class="option">250g</button>
                    <button class="option active">500g</button>
                    <button class="option">1kg</button>
                </div>
            </div>

            <div class="section">
                <p class="label">Số lượng:</p>
                <div class="qty">
                    <button class="qty-btn minus">-</button>
                    <input type="text" value="1">
                    <button class="qty-btn plus">+</button>
                </div>
            </div>

            <div class="btn-group">
                <button class="add-cart"><i class="fa-solid fa-cart-shopping"></i> Thêm vào giỏ hàng</button>
                <a href="giohang.html" class="buy-now">Mua ngay</a>
            </div>
        </div>
    </div>

    <!-- PHẦN CHI TIẾT MÔ TẢ SẢN PHẨM -->
    <div class="product-detail">
        <h3>Chi tiết sản phẩm</h3>
        <p>
            Phần thịt được tuyển chọn từ nguồn bò sạch, nuôi theo tiêu chuẩn an toàn thực phẩm.
            "Nạm bò Úc" là phần thịt bụng của bò Úc, có đặc điểm là thịt và mỡ xen kẽ nhau. Đây là một phần thịt mềm, ngon, thường được sử dụng để chế biến các món ăn phổ biến như phở, bò kho, lẩu hoặc dùng để xào, nướng...
        </p>
        <ul>
            <li>Nguồn gốc: Úc</li>
            <li>Bảo quản: 0 - 4°C</li>
            <li>Hạn sử dụng: 7 ngày kể từ ngày đóng gói</li>
            <li>Đóng gói hút chân không đảm bảo vệ sinh an toàn thực phẩm</li>
        </ul>
    </div>

    <!-- KHU VỰC BÌNH LUẬN -->
    <section class="product-comments">
        <h3>Bình luận</h3>

        <div class="comment-box">
            <textarea placeholder="Viết bình luận của bạn..."></textarea>
            <button>Gửi bình luận</button>
        </div>

        <div class="comments-list">
            <div class="comment-item">
                <p class="user">
                    <strong>Nguyễn Minh Hậu</strong> · 1 ngày trước
                    <span class="stars">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star-half-stroke"></i>
            </span>
                </p>
                <p class="content">Sản phẩm chất lượng, đáng mua!</p>
            </div>

            <div class="comment-item">
                <p class="user">
                    <strong>Trần Thị Ngọc</strong> · 2 ngày trước
                    <span class="stars">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
            </span>
                </p>
                <p class="content">Tiền nào của đó, thịt ăn rất mềm và ngon</p>
            </div>

            <div class="comment-item">
                <p class="user">
                    <strong>Lê Minh Hiếu</strong> · 3 ngày trước
                    <span class="stars">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star-half-stroke"></i>
                <i class="fa-regular fa-star"></i>
            </span>
                </p>
                <p class="content">Khá ưng, nhưng giao hàng hơi lâu</p>
            </div>
        </div>
        <div class="see-more">Xem thêm</div>
    </section>
    <!-- POPUP XEM THÊM BÌNH LUẬN -->
    <div id="comment-popup" class="popup-overlay">
        <div class="popup-content">
            <h3>Tất cả bình luận</h3>

            <div class="popup-comments">

                <div class="comment-item">
                    <p class="user">
                        <strong>Nguyễn Minh Hậu</strong> · 1 ngày trước
                        <span class="stars">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star-half-stroke"></i>
            </span>
                    </p>
                    <p class="content">Sản phẩm chất lượng, đáng mua!</p>
                </div>

                <div class="comment-item">
                    <p class="user">
                        <strong>Trần Thị Ngọc</strong> · 2 ngày trước
                        <span class="stars">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
            </span>
                    </p>
                    <p class="content">Tiền nào của đó, thịt ăn rất mềm và ngon</p>
                </div>

                <div class="comment-item">
                    <p class="user">
                        <strong>Lê Minh Hiếu</strong> · 3 ngày trước
                        <span class="stars">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star-half-stroke"></i>
                <i class="fa-regular fa-star"></i>
            </span>
                    </p>
                    <p class="content">Khá ưng, nhưng giao hàng hơi lâu</p>
                </div>

                <div class="comment-item">
                    <p class="user">
                        <strong>Phạm Lưu Quang</strong> · 3 ngày trước
                        <span class="stars">
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
                <i class="fa-solid fa-star"></i>
            </span>
                    </p>
                    <p class="content">Ngon! đã mua mấy lần từ CleanMeat nhưng chưa bao giờ thất vọng</p>
                </div>

            </div>

            <button class="close-popup">Đóng</button>
        </div>
    </div>
</main>

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
</main>