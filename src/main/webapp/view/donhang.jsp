<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="container">
    <div class="header">
        <h1 class="title big">Đơn hàng của tôi</h1>
    </div>

    <div class="contents">
        <div class="tabs">
            <button class="tab active" data-target="all">Tất cả</button>
            <button class="tab" data-target="waiting">Chờ xác nhận</button>
            <button class="tab" data-target="shipping">Chuẩn bị hàng</button>
            <button class="tab" data-target="delivering">Đang giao hàng</button>
            <button class="tab" data-target="done">Đã giao hàng</button>
            <button class="tab" data-target="cancel">Đã hủy</button>
        </div>

        <div class="orders">
            <div class="order-group" id="all">
                <div class="order-item">
                    <div class="order-header">
                        <span class="order-id">DH001</span>
                        <span class="order-status status-waiting">Chờ xác nhận</span>
                    </div>
                    <div class="order-products">
                        <div class="product">
                            <img src="https://vietmartjp.com/wp-content/uploads/2024/05/kiotviet_e2ee0a463cd2893e6dbc6d3efb773064.jpg"
                                 alt="Mỡ heo">
                            <div class="product-info">
                                <span class="name">Mỡ heo sạch 330gr</span>
                                <span class="qty">x1</span>
                            </div>
                            <span class="price">52,000đ</span>
                        </div>
                        <div class="product">
                            <img src="https://www.thucphamsachhd.com/uploads/files/2023/06/19/thumbs-1024-768-0/HED0002-PD01588-WEB_Ba-Roi-Rut-Suon-Heo-Duc.png"
                                 alt="ba rọi rút sườn">
                            <div class="product-info">
                                <span class="name">Ba rọi rút sườn</span>
                                <span class="qty">x2</span>
                            </div>
                            <span class="price">340,000đ</span>
                        </div>
                    </div>

                    <div class="order-footer">
                        <span class="total">Tổng: 392,000đ</span>
                        <button class="btn-detail"><a href="Chitietdonhang_Choxacnhan.html">Chi tiết</a></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="order-header">
                        <span class="order-id">DH002</span>
                        <span class="order-status status-delivering">Đang giao hàng</span>
                    </div>
                    <div class="order-products">
                        <div class="product">
                            <img src="https://phamgiafood.com.vn/wp-content/uploads/2017/07/ma-dui-ga.jpg"
                                 alt="Má đùi gà">
                            <div class="product-info">
                                <span class="name">Má đùi gà</span>
                                <span class="qty">x1</span>
                            </div>
                            <span class="price">98,000đ</span>
                        </div>
                        <div class="product">
                            <img src="https://phamgiafood.com.vn/wp-content/uploads/2022/05/ucga-2.jpg" alt="Ức gà">
                            <div class="product-info">
                                <span class="name">Thịt ức gà</span>
                                <span class="qty">x2</span>
                            </div>
                            <span class="price">140.000đ</span>
                        </div>
                        <div class="product">
                            <img src="https://salt.tikicdn.com/cache/525x525/ts/product/5a/e5/45/854b408e0ac19f5356555703498e4e1a.png"
                                 alt="Phi lê cổ bò">
                            <div class="product-info">
                                <span class="name">Phi lê cổ bò</span>
                                <span class="qty">x1</span>
                            </div>
                            <span class="price">275,000đ</span>
                        </div>
                    </div>
                    <div class="order-footer">
                        <span class="total">Tổng: 523,000đ</span>
                        <button class="btn-detail"><a href="chitietdonhang_dagiaohang.html">Chi tiết</a></button>
                    </div>
                </div>
                <div class="order-item">
                    <div class="order-header">
                        <span class="order-id">DH003</span>
                        <span class="order-status status-done">Đã giao hàng</span>
                    </div>
                    <div class="order-products">
                        <div class="product">
                            <img src="https://product.hstatic.net/200000423303/product/nam-gau-bo-to_fc79a75a1b3c463381bb22b779e8f808_1024x1024.png"
                                 alt="Nạm gầu bò tơ">
                            <div class="product-info">
                                <span class="name">Nạm gầu bò tơ</span>
                                <span class="qty">x1</span>
                            </div>
                            <span class="price">320.000đ</span>
                        </div>
                    </div>
                    <div class="order-footer">
                        <span class="total">Tổng: 320000đ</span>
                        <button class="btn-detail"><a href="../HTML/chitietdonhang_dagiaohang.html">Chi tiết</a>
                        </button>
                    </div>
                </div>
            </div>

            <div class="order-group hidden" id="waiting">
                <div class="order-item">
                    <div class="order-header">
                        <span class="order-id">DH001</span>
                        <span class="order-status status-waiting">Chờ xác nhận</span>
                    </div>
                    <div class="order-products">
                        <div class="product">
                            <img src="https://vietmartjp.com/wp-content/uploads/2024/05/kiotviet_e2ee0a463cd2893e6dbc6d3efb773064.jpg"
                                 alt="Mỡ heo">
                            <div class="product-info">
                                <span class="name">Mỡ heo sạch 330gr</span>
                                <span class="qty">x1</span>
                            </div>
                            <span class="price">52,000đ</span>
                        </div>
                        <div class="product">
                            <img src="https://www.thucphamsachhd.com/uploads/files/2023/06/19/thumbs-1024-768-0/HED0002-PD01588-WEB_Ba-Roi-Rut-Suon-Heo-Duc.png"
                                 alt="ba rọi rút sườn">
                            <div class="product-info">
                                <span class="name">Ba rọi rút sườn</span>
                                <span class="qty">x2</span>
                            </div>
                            <span class="price">340,000đ</span>
                        </div>
                    </div>

                    <div class="order-footer">
                        <span class="total">Tổng: 392,000đ</span>
                        <button class="btn-detail">Chi tiết</button>
                    </div>
                </div>
            </div>

            <div class="order-group hidden" id="shipping">
                <div class="none">Không có đơn hàng</div>
            </div>

            <div class="order-group hidden" id="delivering">
                <div class="order-item">
                    <div class="order-header">
                        <span class="order-id">DH002</span>
                        <span class="order-status status-delivering">Đang giao hàng</span>
                    </div>
                    <div class="order-products">
                        <div class="product">
                            <img src="https://phamgiafood.com.vn/wp-content/uploads/2017/07/ma-dui-ga.jpg"
                                 alt="Má đùi gà">
                            <div class="product-info">
                                <span class="name">Má đùi gà</span>
                                <span class="qty">x1</span>
                            </div>
                            <span class="price">98,000đ</span>
                        </div>
                        <div class="product">
                            <img src="https://phamgiafood.com.vn/wp-content/uploads/2022/05/ucga-2.jpg" alt="Ức gà">
                            <div class="product-info">
                                <span class="name">Thịt ức gà</span>
                                <span class="qty">x2</span>
                            </div>
                            <span class="price">140.000đ</span>
                        </div>
                        <div class="product">
                            <img src="https://salt.tikicdn.com/cache/525x525/ts/product/5a/e5/45/854b408e0ac19f5356555703498e4e1a.png"
                                 alt="Phi lê cổ bò">
                            <div class="product-info">
                                <span class="name">Phi lê cổ bò</span>
                                <span class="qty">x1</span>
                            </div>
                            <span class="price">275,000đ</span>
                        </div>
                    </div>

                    <div class="order-footer">
                        <span class="total">Tổng: 523,000đ</span>
                        <button class="btn-detail">Chi tiết</button>
                    </div>
                </div>
            </div>

            <div class="order-group hidden" id="done">
                <div class="order-item">
                    <div class="order-header">
                        <span class="order-id">DH003</span>
                        <span class="order-status status-done">Đã giao hàng</span>
                    </div>
                    <div class="order-products">
                        <div class="product">
                            <img src="https://product.hstatic.net/200000423303/product/nam-gau-bo-to_fc79a75a1b3c463381bb22b779e8f808_1024x1024.png"
                                 alt="Nạm gầu bò tơ">
                            <div class="product-info">
                                <span class="name">Nạm gầu bò tơ</span>
                                <span class="qty">x1</span>
                            </div>
                            <span class="price">320.000đ</span>
                        </div>
                    </div>

                    <div class="order-footer">
                        <span class="total">Tổng: 320000đ</span>
                        <button class="btn-detail">Chi tiết</button>
                    </div>
                </div>
            </div>

            <div class="order-group hidden" id="cancel">
                <div class="none">Không có đơn hàng</div>
            </div>
        </div>
    </div>
</div>
