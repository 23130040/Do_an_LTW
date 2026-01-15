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
