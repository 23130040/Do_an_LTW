<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-item">
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>
                                <div class="order-products">
                                    <c:forEach var="${item}" items="">
                                        <div class="product">
                                            <img src="#" alt="">
                                            <div class="product-info">
                                                <span class="name"></span>
                                                <span class="qty"></span>
                                            </div>
                                            <span class="price">52,000đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}</span>
                                    <button class="btn-detail"><a href="${pageContext.request.pageContext}/">Chi
                                        tiết</a>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="none">Không có đơn hàng</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="order-group hidden" id="delivering">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-item">
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>
                                <div class="order-products">
                                    <c:forEach var="${item}" items="">
                                        <div class="product">
                                            <img src="#" alt="">
                                            <div class="product-info">
                                                <span class="name"></span>
                                                <span class="qty"></span>
                                            </div>
                                            <span class="price">52,000đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}</span>
                                    <button class="btn-detail"><a href="${pageContext.request.pageContext}/">Chi
                                        tiết</a>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="none">Không có đơn hàng</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="order-group hidden" id="done">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-item">
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>
                                <div class="order-products">
                                    <c:forEach var="${item}" items="">
                                        <div class="product">
                                            <img src="#" alt="">
                                            <div class="product-info">
                                                <span class="name"></span>
                                                <span class="qty"></span>
                                            </div>
                                            <span class="price">52,000đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}</span>
                                    <button class="btn-detail"><a href="${pageContext.request.pageContext}/">Chi
                                        tiết</a>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="none">Không có đơn hàng</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="order-group hidden" id="cancel">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-item">
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>
                                <div class="order-products">
                                    <c:forEach var="${item}" items="">
                                        <div class="product">
                                            <img src="#" alt="">
                                            <div class="product-info">
                                                <span class="name"></span>
                                                <span class="qty"></span>
                                            </div>
                                            <span class="price">52,000đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}</span>
                                    <button class="btn-detail"><a href="${pageContext.request.pageContext}/">Chi
                                        tiết</a>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="none">Không có đơn hàng</div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</div>
