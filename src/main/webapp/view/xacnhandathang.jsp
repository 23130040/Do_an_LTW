<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="container">
    <div class="back-button-wrapper">
        <a href="${pageContext.request.contextPath}/gio-hang" class="back-button">
            <i class="fa-solid fa-angle-left"></i> Quay lại
        </a>
    </div>
    <div class="header">
        <h3 class="title big">Xác nhận đặt hàng</h3>
    </div>
    <div class="wrapper profile">
        <div class="wrapper-header" id="profile-header">
            <h3 class="title small">Thông tin người nhận</h3>
            <div class="profile-edit">
                <i class="fa-solid fa-pen-to-square" id="edit-profile"
                   title="Nhấn vào đây để chỉnh sửa thông tin"></i>
            </div>
        </div>
        <div id="profile-contents">
            <div class="profile-left">
                <p id="contact-info">
                    <span class="detail" id="name">${user.name}</span>
                    <span class="detail" id="phone-number">${user.phone}</span>
                </p>
            </div>
            <div class="profile-right">
                <p id="address">${defaultAddress != null ? defaultAddress.address : "Chưa có địa chỉ mặc định"}</p>
                <div class="block-default">
                    <p id="tag-default">
                        Mặc định
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div class="wrapper product">
        <div class="wrapper-header">
            <h3 class="title small">Thông tin sản phẩm</h3>
        </div>
        <div id="product-contents">
            <table class="product table">
                <tr class="table-header">
                    <th class="header-item product">Sản phẩm</th>
                    <th class="header-item unit">Quy cách</th>
                    <th class="header-item price">Đơn giá</th>
                    <th class="header-item amount">Số lượng</th>
                    <th class="header-item total">Tổng tiền</th>
                </tr>
                <c:forEach var="cartItem" items="${cart.list}">
                    <tr class="table-detail">
                        <td class="order-table-item product">
                            <div class="product-wrapper">
                                <img src="${pageContext.request.contextPath}/images/${cartItem.item.imageUrl}"
                                     alt="${cartItem.item.name}">
                                <span class="detail">${cartItem.item.name}</span>
                            </div>
                        </td>
                        <td class="order-table-item unit">
                            <span class="detail">${cartItem.item.unitName}</span>
                        </td>
                        <td class="order-table-item price">
                            <span class="detail">
                                <fmt:formatNumber value="${cartItem.item.price}" type="number"
                                                  groupingUsed="true"/></span>
                            <span class="detail">đ</span>
                        </td>
                        <td class="order-table-item amount">
                            <span class="detail">${cartItem.quantity}</span>
                        </td>
                        <td class="order-table-item total">
                            <span class="detail">
                                <fmt:formatNumber value="${cartItem.subTotal}" type="number" groupingUsed="true"/>
                            <span class="detail">đ</span>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div id="product-totalAll">
            <span class="detail">Tổng số tiền:</span>
            <span class="detail" id="totalAll">
                <fmt:formatNumber value="${cart.total}" type="number" groupingUsed="true"/> đ
            </span>
        </div>
    </div>
    <div class="wrapper payment">
        <div class="wrapper-header">
            <h3 class="title small">Phương thức thanh toán</h3>
        </div>
        <div id="payment-contents">
            <div class="payment-item">
                <input type="radio" id="cash-on-delivery" name="payment-type" checked>
                <label for="cash-on-delivery" class="radio-label">Thanh toán khi nhận hàng</label>
            </div>
        </div>
    </div>
    <div class="wrapper overall-cost">
        <div id="overall-cost-contents">
            <table class="cost table">
                <tr class="table row">
                    <th class="header-item">Tổng tiền hàng:</th>
                    <td class="cost-item" id="totalCostProducts">
                        <fmt:formatNumber value="${cart.total}" type="number" groupingUsed="true"/> đ
                    </td>
                </tr>
                <tr class="table row">
                    <th class="header-item">Phí vận chuyển
                        <i class="fa-solid fa-circle-exclamation" id="opendeliverymessage"></i>:
                    </th>
                    <td class="cost-item" id="deliveryFee">0 đ</td>
                </tr>
                <tr class="table row">
                    <th class="header-item">Thành tiền:</th>
                    <td class="cost-item" id="overallCost">
                        <fmt:formatNumber value="${cart.total}" type="number" groupingUsed="true"/> đ
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="wrapper confirm">
        <button id="confirmOrder" title="Nhấn để hoàn tất đơn hàng!">ĐẶT HÀNG</button>
    </div>
</div>
<div id="redirect-modal" class="modal">
    <div class="modal-content">
        <div class="message">
            <p class="txt">
                <i class="fa-solid fa-circle-check"></i>
                Đặt hàng thành công!
            </p>
            <p id="message-confirm">Vui lòng không thanh toán trước khi nhận hàng!</p>
            <div class="btn">
                <button id="return-to-home-btn">Quay về trang chủ</button>
                <button id="view-orders-btn">Xem đơn hàng của tôi</button>
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
                * Miễn phí vận chuyển cho tất cả các đơn hàng.
            </p>
        </div>
    </div>
</div>
<div id="edit-profile-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-edit-profile-modal">&times;</span>
        <div class="profile">
            <h3>Tên người nhận</h3>
            <input type="text" name="name" class="input-text" placeholder="Nhập tên người nhận">
            <h3>Số điện thoại</h3>
            <input type="text" name="phoneNumber" class="input-text" placeholder="Nhập số điện thoại">
            <h3>Thay đổi địa chỉ</h3>
            <div class="address-content">
                <c:forEach var="addr" items="${addressList}">
                    <div class="address ${addr.defaultAddress ? 'check' : ''}"
                         data-id="${addr.id}"
                         data-is-default="${addr.defaultAddress}">
                        <p class="address-detail">${addr.address}</p>
                        <c:if test="${addr.defaultAddress}">
                            <span class="address-default">Mặc định</span>
                        </c:if>
                    </div>
                </c:forEach>
                <button id="add-address-btn">+ Thêm địa chỉ</button>
            </div>
            <div class="btn">
                <button id="cancle-edit-profile-btn" class="cancle-btn">Hủy</button>
                <button id="confirm-edit-profile-btn" class="confirm-btn">Xác nhận</button>
            </div>
        </div>
    </div>
</div>
<div id="add-address-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" id="close-add-address-modal">&times;</span>
        <div class="address-form">
            <h3>Thông tin địa chỉ khác</h3>
            <form class="address-form" action="${pageContext.request.contextPath}/dia-chi" method="post">
                <h2 id="header-address">Thêm địa chỉ mới</h2>
                <div class="form-row">
                    <div class="form-group">
                        <label for="address-detail">Địa chỉ mới (*)</label>
                        <textarea name="address" id="address-detail" rows="3"
                                  placeholder="Ví dụ: 123/45 Đường Quang Trung, gần chợ A, phường B, huyện C, tỉnh D..."
                                  required></textarea>
                    </div>
                </div>
                <input type="hidden" name="action" id="address-action">
                <input type="hidden" name="addressId" id="modal-address-id">
                <button type="submit" id="submit-btn">Lưu Địa Chỉ</button>
            </form>
        </div>
    </div>
</div>
