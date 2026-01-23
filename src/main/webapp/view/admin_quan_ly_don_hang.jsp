<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Đơn Hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_quan_ly_don_hang.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp"/>

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="order"/>
        </jsp:include>
        <!------------------- QUẢN LÝ ĐƠN HÀNG ----------------->
        <main class="content">
            <h2 class="page-title">Quản Lý Đơn Hàng</h2>

            <div class="control-panel">
                <div class="filters">
                    <input type="text" placeholder="Tìm kiếm đơn hàng" class="search-input" id="searchInput"
                           value="${searchKeyword}">

                    <select name="status" class="filter-select" id="statusFilter">
                        <option value="">-- Tất cả trạng thái --</option>
                        <option value="Chờ xác nhận" ${selectedStatus == 'Chờ xác nhận' ? 'selected' : ''}>Chờ xác
                            nhận
                        </option>
                        <option value="Đang giao" ${selectedStatus == 'Đang giao' ? 'selected' : ''}>Đang giao hàng
                        </option>
                        <option value="Đã giao" ${selectedStatus == 'Đã giao' ? 'selected' : ''}>Đã giao hàng</option>
                        <option value="Đã hủy" ${selectedStatus == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
                    </select>

                    <input type="date" class="filter-date" title="Lọc theo ngày đặt hàng">
                </div>

            </div>

            <div class="order-table-container">
                <table class="order-table">
                    <thead>
                    <tr>
                        <th>Mã ĐH</th>
                        <th>Khách hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái Đơn hàng</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>${o.id}</td>
                            <td>
                                    ${o.user.name}<br>
                                <small>${o.user.phone}</small>
                            </td>
                            <td>
                                    ${o.created_at.hour < 10 ? '0' : ''}${o.created_at.hour}:${o.created_at.minute < 10 ? '0' : ''}${o.created_at.minute}
                                <br>
                                    ${o.created_at.dayOfMonth < 10 ? '0' : ''}${o.created_at.dayOfMonth}-${o.created_at.monthValue < 10 ? '0' : ''}${o.created_at.monthValue}-${o.created_at.year}
                            </td>
                            <td>
                                <fmt:formatNumber value="${o.total_price}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${o.status == 'Chờ xác nhận'}">
            <span class="badge status-pending-bg">
                    ${o.status}
            </span>
                                    </c:when>
                                    <c:when test="${o.status == 'Đang giao'}">
            <span class="badge status-shipping-bg">
                    ${o.status}
            </span>
                                    </c:when>
                                    <c:when test="${o.status == 'Đã giao'}">
            <span class="badge status-delivered-bg">
                    ${o.status}
            </span>
                                    </c:when>
                                    <c:when test="${o.status == 'Đã hủy'}">
            <span class="badge status-cancelled-bg">
                    ${o.status}
            </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${o.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn-sm btn-action view-detail"
                                        data-id="${o.id}"
                                        data-status="${o.status}"
                                        data-date="${o.created_at}"
                                        data-customer="${o.user.name}"
                                        data-phone="${o.user.phone}"
                                        data-address="${o.address.address}"
                                        data-total="<fmt:formatNumber value='${o.total_price}' type='currency' currencySymbol='đ' maxFractionDigits='0'/>">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}&status=${selectedStatus}&search=${searchKeyword}">&laquo;
                        Trước</a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="?page=${i}&status=${selectedStatus}&search=${searchKeyword}"
                       class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}&status=${selectedStatus}&search=${searchKeyword}">Sau &raquo;</a>
                </c:if>
            </div>
        </main>
    </div>
    <!------------------- PHẦN THÔNG BÁO ----------------->
    <div id="notification-panel" class="notification-panel">
        <div class="panel-header">
            <h3>Thông Báo Mới (3)</h3>
            <span class="close-panel-btn" onclick="toggleNotificationMenu()">&times;</span>
        </div>
        <div class="panel-content">
            <a href="#" class="notification-item unread">
                <i class="fas fa-shopping-cart"></i>
                <p>Đơn hàng mới #0012 vừa được tạo.</p>
            </a>
            <a href="#" class="notification-item unread">
                <i class="fas fa-exclamation-triangle"></i>
                <p>Tồn kho Thịt Bò Thăn Nội < 5kg.</p>
            </a>
            <a href="#" class="notification-item">
                <i class="fas fa-comment"></i>
                <p>Có 1 phản hồi mới cho sản phẩm Thịt Heo.</p>
            </a>
        </div>
    </div>
</div>
<!------------------- MODAL CHI TIẾT ĐƠN HÀNG ----------------->
<div id="orderDetailModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Chi Tiết Đơn Hàng <span id="modalOrderId"></span></h3>
            <span class="close-btn">&times;</span>
        </div>
        <div class="modal-body">
            <div class="summary-info">
                <div class="summary-item">
                    <p class="summary-label">Trạng thái Đơn hàng:</p>
                    <p id="modalOrderStatus" class="status-badge"></p></div>
                <div class="summary-item">
                    <p class="summary-label">Ngày đặt:</p>
                    <p id="modalOrderDate"></p>
                </div>
            </div>

            <div class="section-container">
                <h4><i class="fas fa-user"></i> Thông tin Khách hàng & Giao hàng</h4>
                <div class="info-grid">
                    <p><strong>Khách hàng:</strong> <span id="modalCustomerName"></span></p>
                    <p><strong>Điện thoại:</strong> <span id="modalCustomerPhone"></span></p>
                    <p><strong>Địa chỉ Giao hàng:</strong> <span id="modalShippingAddress"></span></p>
                </div>
            </div>

            <div class="section-container">
                <h4><i class="fas fa-boxes"></i> Sản phẩm trong đơn hàng</h4>
                <table class="product-table">
                    <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>SL</th>
                        <th>Tổng</th>
                    </tr>
                    </thead>
                    <tbody id="modalProductList">
                    </tbody>
                </table>
            </div>

            <div class="total-summary">
                <h4 class="grand-total">Tổng thanh toán: <span id="modalGrandTotal"></span></h4>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary close-btn-footer">Đóng</button>
        </div>
    </div>
</div>
<script>
    const CONTEXT_PATH = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_don_hang.js"></script>
</body>
</html>