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
            <button class="tab" data-target="preparing">Chuẩn bị hàng</button>
            <button class="tab" data-target="delivering">Đang giao hàng</button>
            <button class="tab" data-target="done">Đã giao hàng</button>
            <button class="tab" data-target="cancel">Đã hủy</button>
        </div>

        <form class="orders" method="get" action="${pageContext.request.contextPath}/don-hang-cua-toi">
            <div class="order-group" id="all">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-item" data-status="${order.status}">

                                <!--HEADER-->
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>

                                <!--PRODUCT-->
                                <div class="order-products">
                                    <c:forEach var="oi" items="${order.listItem}">
                                        <div class="product">
                                            <img src="${oi.item.image}" alt="">
                                            <div class="product-info">
                                                <span class="name">${oi.item.name}</span>
                                                <span class="qty">${oi.quantity}</span>
                                            </div>
                                            <span class="price">${oi.price}đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}đ</span>
                                    <button class="btn-detail"><a
                                            href="${pageContext.request.pageContext}/chi-tiet-don-hang?id=${order.id}">
                                        Chi tiết</a>
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

            <div class="order-group hidden" id="waiting">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-item" data-status="${order.status}">

                                <!--HEADER-->
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>

                                <!--PRODUCT-->
                                <div class="order-products">
                                    <c:forEach var="oi" items="${order.listItem}">
                                        <div class="product">
                                            <img src="${oi.item.image}" alt="">
                                            <div class="product-info">
                                                <span class="name">${oi.item.name}</span>
                                                <span class="qty">${oi.quantity}</span>
                                            </div>
                                            <span class="price">${oi.price}đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}đ</span>
                                    <button class="btn-detail"><a
                                            href="${pageContext.request.pageContext}/chi-tiet-don-hang?id=${order.id}">
                                        Chi tiết</a>
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

            <div class="order-group hidden" id="preparing">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-item" data-status="${order.status}">

                                <!--HEADER-->
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>

                                <!--PRODUCT-->
                                <div class="order-products">
                                    <c:forEach var="oi" items="${order.listItem}">
                                        <div class="product">
                                            <img src="${oi.item.image}" alt="">
                                            <div class="product-info">
                                                <span class="name">${oi.item.name}</span>
                                                <span class="qty">${oi.quantity}</span>
                                            </div>
                                            <span class="price">${oi.price}đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}đ</span>
                                    <button class="btn-detail"><a
                                            href="${pageContext.request.pageContext}/chi-tiet-don-hang?id=${order.id}">
                                        Chi tiết</a>
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
                            <div class="order-item" data-status="${order.status}">

                                <!--HEADER-->
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>

                                <!--PRODUCT-->
                                <div class="order-products">
                                    <c:forEach var="oi" items="${order.listItem}">
                                        <div class="product">
                                            <img src="${oi.item.image}" alt="">
                                            <div class="product-info">
                                                <span class="name">${oi.item.name}</span>
                                                <span class="qty">${oi.quantity}</span>
                                            </div>
                                            <span class="price">${oi.price}đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}đ</span>
                                    <button class="btn-detail"><a
                                            href="${pageContext.request.pageContext}/chi-tiet-don-hang?id=${order.id}">
                                        Chi tiết</a>
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
                            <div class="order-item" data-status="${order.status}">

                                <!--HEADER-->
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>

                                <!--PRODUCT-->
                                <div class="order-products">
                                    <c:forEach var="oi" items="${order.listItem}">
                                        <div class="product">
                                            <img src="${oi.item.image}" alt="">
                                            <div class="product-info">
                                                <span class="name">${oi.item.name}</span>
                                                <span class="qty">${oi.quantity}</span>
                                            </div>
                                            <span class="price">${oi.price}đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}đ</span>
                                    <button class="btn-detail"><a
                                            href="${pageContext.request.pageContext}/chi-tiet-don-hang?id=${order.id}">
                                        Chi tiết</a>
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
                            <div class="order-item" data-status="${order.status}">

                                <!--HEADER-->
                                <div class="order-header">
                                    <span class="order-id">#${order.id}</span>
                                    <span class="order-status status-waiting">${order.status}</span>
                                </div>

                                <!--PRODUCT-->
                                <div class="order-products">
                                    <c:forEach var="oi" items="${order.listItem}">
                                        <div class="product">
                                            <img src="${oi.item.image}" alt="">
                                            <div class="product-info">
                                                <span class="name">${oi.item.name}</span>
                                                <span class="qty">${oi.quantity}</span>
                                            </div>
                                            <span class="price">${oi.price}đ</span>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="order-footer">
                                    <span class="total">Tổng: ${order.total_price}đ</span>
                                    <button class="btn-detail"><a
                                            href="${pageContext.request.pageContext}/chi-tiet-don-hang?id=${order.id}">
                                        Chi tiết</a>
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
        </form>
    </div>
</div>
