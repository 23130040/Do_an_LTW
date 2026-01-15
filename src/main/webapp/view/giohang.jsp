<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<header>
    <div class="title">GIỎ HÀNG CỦA BẠN</div>
</header>
<div class="contents">
    <div class="order details">
        <table class="order-table">
            <tr class="order-table-header">
                <th class="header product">Sản phẩm</th>
                <th class="header price">Đơn giá</th>
                <th class="header amount">Số lượng</th>
                <th class="header sum">Thành tiền</th>
                <th class="header trash"></th>
            </tr>
            <tr class="order-table-body" id="product1">
                <td class="order-table-item product">
                    <div class="product-wrapper">
                        <img src="https://vietmartjp.com/wp-content/uploads/2024/05/kiotviet_e2ee0a463cd2893e6dbc6d3efb773064.jpg"
                             alt="Mỡ heo">
                        <span class="detail">Mỡ heo sạch 330gr</span>
                    </div>
                </td>
                <td class="order-table-item price">
                    <span id="price1">52,000</span>
                    <span class="detail">đ/phần</span>
                </td>
                <td class="order-table-item amount">
                    <div class="amount-wrapper">
                        <button type="button" data-action="decrease" class="quantity-btn" id="decrease1">-</button>
                        <input type="text" class="quantity-input" value="1" id="SP001">
                        <button type="button" data-action="increase" class="quantity-btn" id="increase1">+</button>
                        <span class="detail">phần</span>
                    </div>
                </td>
                <td class="order-table-item sum">
                    <span class="total" id="sum1"></span>
                    <span class="detail">đ</span>
                </td>
                <td class="order-table-item trash" id="trash1">
                    <i class="fa-solid fa-trash"></i>
                </td>
            </tr>
            <tr class="order-table-body" id="product2">
                <td class="order-table-item product">
                    <div class="product-wrapper">
                        <img src="https://phamgiafood.com.vn/wp-content/uploads/2022/05/ucga-2.jpg" alt="Thịt ức gà">
                        <span class="detail">Thịt ức gà</span>
                    </div>
                </td>
                <td class="order-table-item price">
                    <span id="price2">70,000</span>
                    <span class="detail">đ/Kg</span>
                </td>
                <td class="order-table-item amount">
                    <div class="amount-wrapper">
                        <button type="button" data-action="decrease" class="quantity-btn" id="decrease2">-</button>
                        <input type="text" class="quantity-input" value="0.1" id="SP002">
                        <button type="button" data-action="increase" class="quantity-btn" id="increase2">+</button>
                        <span class="detail">Kg</span>
                    </div>
                </td>
                <td class="order-table-item sum">
                    <span class="total" id="sum2"></span>
                    <span class="detail">đ</span>
                </td>
                <td class="order-table-item trash" id="trash2">
                    <i class="fa-solid fa-trash"></i>
                </td>
            </tr>
            <tr class="order-table-body" id="product3">
                <td class="order-table-item product">
                    <div class="product-wrapper">
                        <img src="https://fohlafood.vn/cdn/shop/articles/1-1683857652-150-width800height550.jpg?v=1732018733"
                             alt="Thịt bò tươi">
                        <span class="detail">Thịt bò tươi</span>
                    </div>
                </td>
                <td class="order-table-item price">
                    <span id="price3">350,000</span>
                    <span class="detail">đ/Kg</span>
                </td>
                <td class="order-table-item amount">
                    <div class="amount-wrapper">
                        <button type="button" data-action="decrease" class="quantity-btn" id="decrease3">-</button>
                        <input type="text" class="quantity-input" value="0.1" id="SP003">
                        <button type="button" data-action="increase" class="quantity-btn" id="increase3">+</button>
                        <span class="detail">Kg</span>
                    </div>
                </td>
                <td class="order-table-item sum">
                    <span class="total" id="sum3"></span>
                    <span class="detail">đ</span>
                </td>
                <td class="order-table-item trash" id="trash3">
                    <i class="fa-solid fa-trash"></i>
                </td>
            </tr>
        </table>
    </div>
    <div class="order summary">
        <div class="container">
            <div class="order-summary header">Tóm tắt đơn hàng</div>
            <div class="order-summary center">
                <div class="order-summary total">
                    <p>
                        <span class="total txt">Tổng tiền hàng:</span>
                        <span class="total number" id="total-order"></span>
                    </p>
                </div>
                <div class="order-summary discount">
                    <p>
                        <span class="discount txt">Giảm giá:</span>
                        <span class="discount number" id="discount">0</span>
                    </p>
                </div>
                <div class="order-summary delivery-fee">
                    <p>
                                <span class="delivery-fee txt">
                                    <i class="fa-solid fa-circle-exclamation" id="opendeliverymessage"></i>
                                    Phí vận chuyển:</span>
                        <span class="delivery-fee number" id="delivery">0</span>
                    </p>
                </div>
                <div class="order-summary amount">
                    <p>
                        <span class="amount txt">Thành tiền:</span>
                        <span class="amount number" id="subtotal"></span>
                    </p>
                </div>
            </div>
            <div class="order-summary voucher">
                <label for="voucher">Mã giảm giá:</label>
                <div class="voucher-input">
                    <input type="text" id="voucher" placeholder="Nhập mã voucher">
                    <button id="applyVoucher">Áp dụng</button>
                </div>
                <p class="voucher-message"></p>
            </div>
            <div class="order-summary footer">
                <a href="xacnhandathang.html">
                    <button onclick="" class="order-summary submit" id="submit-btn">MUA HÀNG</button>
                </a>
            </div>
        </div>
    </div>
</div>
<div id="delivery-message" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-message-modal">&times;</span>
        <div class="message">
            <h3 class="message-header">Thông tin vận chuyển</h3>
            <p class="txt">
                <span class="bold">Phí vận chuyển</span><br>
                * Miễn phí vận chuyển cho tất cả đơn hàng.
            </p>
        </div>
    </div>
</div>
