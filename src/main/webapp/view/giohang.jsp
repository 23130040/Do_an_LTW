<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<header>
    <div class="title">GIỎ HÀNG CỦA BẠN</div>
</header>
<div class="contents">
    <div class="order details">
        <table class="order-table">
            <tr class="order-table-header">
                <th class="header product">Sản phẩm</th>
                <th clas="header unit">Quy cách</th>
                <th class="header price">Đơn giá</th>
                <th class="header amount">Số lượng</th>
                <th class="header sum">Thành tiền</th>
                <th class="header trash"></th>
            </tr>
            <c:choose>
                <c:when test="${not empty cart.list}">
                    <c:forEach var="cartItem" items="${cart.list}">
                        <tr class="order-table-body">
                            <td class="order-table-item product">
                                <div class="product-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/${cartItem.item.imageUrl}"
                                         alt="${cartItem.item.name}">
                                    <span class="detail">${cartItem.item.name}</span>
                                </div>
                            </td>
                            <td class="order-table-item unit">
                                <span>${cartItem.item.unitName}</span>
                            </td>
                            <td class="order-table-item price">
                                <span><fmt:formatNumber value="${cartItem.item.price}" type="number"
                                                        groupingUsed="true"/></span>
                                <span class="detail">đ</span>
                            </td>
                            <td class="order-table-item amount">
                                <div class="amount-wrapper">
                                    <button type="button" data-action="decrease" class="quantity-btn"
                                            data-id="${cartItem.id}">-
                                    </button>
                                    <input type="text" class="quantity-input" value="${cartItem.quantity}"
                                           data-id="${cartItem.id}">
                                    <button type="button" data-action="increase" class="quantity-btn"
                                            data-id="${cartItem.id}">+
                                    </button>
                                </div>
                            </td>
                            <td class="order-table-item sum">
                                <span class="total">
                                    <fmt:formatNumber value="${cartItem.subTotal}" type="number"
                                                      groupingUsed="true"/></span>
                                <span class="detail">đ</span>
                            </td>
                            <td class="order-table-item trash">
                                <button type="button" class="trash-btn" data-id="${cartItem.id}">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr class="empty-cart-row">
                        <td colspan="5">
                            <div class="empty-cart">
                                <p>Không có sản phẩm trong giỏ hàng</p>
                                <a href="san-pham">
                                    <button class="buy-now-btn">Mua hàng ngay</button>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </table>
    </div>
    <div class="order summary">
        <div class="container">
            <div class="order-summary header">Tóm tắt đơn hàng</div>
            <div class="order-summary center">
                <div class="order-summary total">
                    <p>
                        <span class="total txt">Tổng tiền hàng:</span>
                        <span class="total number">
                            <fmt:formatNumber value="${cart.total}" type="number" groupingUsed="true"/>
                        </span>
                    </p>
                </div>
                <div class="order-summary delivery-fee">
                    <p>
                        <span class="delivery-fee txt">
                            <i class="fa-solid fa-circle-exclamation"
                               id="opendeliverymessage"></i>Phí vận chuyển:</span>
                        <span class="delivery-fee number" id="delivery">0</span>
                    </p>
                </div>
                <div class="order-summary amount">
                    <p>
                        <span class="amount txt">Thành tiền:</span>
                        <span class="amount number" id="subtotal">
                            <fmt:formatNumber value="${cart.total}" type="number" groupingUsed="true"/>
                        </span>
                    </p>
                </div>
            </div>
            <div class="order-summary footer">
                <c:url var="checkoutUrl" value="/xac-nhan-dat-hang" />
                <a href="${not empty cart.list ? checkoutUrl : '#'}">
                    <button type="button" class="order-summary submit"
                            id="submit-btn" ${empty cart.list ? 'disabled' : ''}>
                        MUA HÀNG
                    </button>
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
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>