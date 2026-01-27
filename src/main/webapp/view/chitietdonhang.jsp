<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="order-container" id="order-DH001">
    <div class="back-button-wrapper">
        <a href="${pageContext.request.contextPath}/don-hang-cua-toi" class="back-button">
            <i class="fa-solid fa-angle-left"></i> Quay lại
        </a>
    </div>
    <h2 class="order-title">Chi tiết đơn hàng #${order.id}</h2>

    <div class="customer-info" id="customer-info">
        <h3 class="section-title">Thông tin người nhận</h3>
        <p class="customer-name"><strong>Họ tên:</strong> ${order.user.name}</p>
        <p class="customer-phone"><strong>Số điện thoại:</strong> ${order.user.phone}</p>
        <p class="customer-address"><strong>Địa chỉ:</strong> ${order.address.address}</p>
    </div>

    <div class="products" id="products">
        <h3 class="section-title">Sản phẩm</h3>
        <table class="product-table">
            <thead>
            <tr>
                <th class="product-name-header">Sản phẩm</th>
                <th class="product-unit-header">Quy cách</th>
                <th class="product-price-header">Đơn giá</th>
                <th class="product-quantity-header">Số lượng</th>
                <th class="product-total-header">Tổng tiền</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="oi" items="${order.listItem}">
                <tr class="product-item">
                    <td class="product-info">
                        <img class="product-image"
                             src="${oi.item.imageUrl}"
                             alt="${oi.item.name}">
                        <span class="product-name-text">${oi.item.name}</span>
                    </td>
                    <td class="product-unit">${oi.item.unitName}</td>
                    <td class="product-price">
                        <fmt:formatNumber value="${oi.price}" type="number" groupingUsed="true"/> đ
                    </td>
                    <td class="product-quantity">${oi.quantity}</td>
                    <td class="product-total">
                        <fmt:formatNumber value="${oi.subTotal}" type="number" groupingUsed="true"/> đ
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="order-status" id="order-status">
        <h3 class="section-title">Trạng thái đơn hàng</h3>
        <p class="italic-txt">Đơn hàng được đặt vào lúc <fmt:formatDate value="${created_at}"
                                                                        pattern="HH:mm:ss dd/MM/yyyy"/></p>
        <div class="status-bar">
            <c:set var="st" value="${order.status}"/>

            <div class="status-step ${st == 'Chờ Xác Nhận' || st == 'Đang Giao' || st == 'Đã Giao' ? 'status-active' : ''}">
                Chờ xác nhận
            </div>
            <div class="status-step ${st == 'Đang Giao' || st == 'Đã Giao' ? 'status-active' : ''}">
                Đang giao
            </div>
            <div class="status-step ${st == 'Đã Giao' ? 'status-active' : ''}">
                Đã giao
            </div>
        </div>
    </div>

    <div class="total" id="order-total">
        <table class="cost table">
            <tr class="table row">
                <th class="header-item">Tổng tiền hàng:</th>
                <td class="cost-item" id="total-cost-products">
                    <fmt:formatNumber value="${order.total_price}" type="number" groupingUsed="true"/> đ
                </td>
            </tr>
            <tr class="table row">
                <th class="header-item">Phí vận chuyển
                    <i class="fa-solid fa-circle-exclamation" id="open-delivery-message"></i>:
                </th>
                <td class="cost-item" id="delivery-fee">0 đ</td>
            </tr>
            <tr class="table row">
                <th class="header-item">Thành tiền:</th>
                <td class="cost-item" id="overall-cost">
                    <fmt:formatNumber value="${order.total_price}" type="number" groupingUsed="true"/> đ
                </td>
            </tr>
        </table>
    </div>
    <div class="footer" id="order-footer">
        <span class="italic-txt">Dự kiến đơn hàng sẽ được giao trong khoảng 2 đến 3 ngày</span>
        <c:choose>
            <c:when test="${order.status == 'Chờ Xác Nhận'}">
                <button class="confirm-btn" id="cancel-order-btn" data-id="${order.id}">Hủy đơn hàng</button>
                <button class="confirm-btn btn-disabled" disabled>Đã nhận hàng</button>
            </c:when>

            <c:when test="${order.status == 'Đang Giao'}">
                <button class="confirm-btn btn-disabled" disabled>Hủy đơn hàng</button>
                <button class="confirm-btn" id="confirm-order-btn" data-id="${order.id}">Đã nhận hàng</button>
            </c:when>

            <c:when test="${order.status == 'Đã Giao'}">
                <button class="confirm-btn" id="review-btn">Đánh giá</button>
            </c:when>
        </c:choose>
    </div>
</div>
<div id="delivery-message" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-message-modal">&times;</span>
        <div class="message">
            <h3 class="message-header">Thông tin vận chuyển</h3>
            <p class="txt">
                <span class="bold">Phí vận chuyển</span><br>
                * Miễn phí vận chuyển cho tất cả các đơn hàng.
            </p>
        </div>
    </div>
</div>
<div id="confirm-return-order-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-confirm-return-order-modal">&times;</span>
        <div class="message">
            <p class="txt">Xác nhận hoàn trả đơn hàng?</p>
            <div class="btn">
                <button id="cancle-btn">Hủy</button>
                <button id="confirm-btn">Xác nhận</button>
            </div>
        </div>
    </div>
</div>
<div id="redirect-modal" class="modal">
    <div class="modal-content">
        <div class="message">
            <p class="txt">
                <i class="fa-solid fa-circle-check"></i>
                Giao hàng thành công!
            </p>
            <div class="btn">
                <button id="return-to-home-btn">Quay về trang chủ</button>
                <button id="view-orders-btn">Xem đơn hàng của tôi</button>
            </div>
        </div>
    </div>
</div>
<script>
    window.contextPath = "${pageContext.request.contextPath}";
</script>