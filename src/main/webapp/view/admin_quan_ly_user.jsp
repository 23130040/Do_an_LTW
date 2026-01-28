<%@ page import="cleanmeat.dao.UserDAO" %>
<%@ page import="cleanmeat.model.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_quan_ly_user.css">


</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp"/>

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="user"/>
        </jsp:include>

        <!---------------- QUẢN LÝ NGƯỜI DÙNG ------------------->
        <main class="content">
            <h2 class="page-title">Quản Lý Người Dùng</h2>

            <div class="control-panel">
                <div class="filters">
                    <input type="text"
                           placeholder="Tìm kiếm theo Tên, Email, SĐT..."
                           class="search-input"
                           id="searchInput"
                           value="${searchKeyword}">

                    <select name="role" class="filter-select" id="roleFilter">
                        <option value="">-- Phân quyền --</option>
                        <option value="customer" ${filterRole eq 'customer' ? 'selected' : ''}>Khách hàng</option>
                        <option value="admin" ${filterRole eq 'admin' ? 'selected' : ''}>Quản trị viên</option>
                    </select>

                </div>
                <button class="btn btn-primary" onclick="openUserModal()">
                    <i class="fas fa-user-plus"></i> Thêm Người Dùng
                </button>
            </div>

            <div class="user-table-container">
                <c:set var="currentUser" value="${sessionScope.user}"/>
                <table class="user-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Thông tin liên hệ</th>
                        <th>Phân quyền</th>
                        <th>Lịch sử mua hàng</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>${u.id}</td>
                            <td>${u.name}</td>
                            <td>${u.email}<br>${u.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.role eq 'admin'}">
                                        Quản trị viên
                                    </c:when>
                                    <c:when test="${u.role eq 'customer'}">
                                        Khách hàng
                                    </c:when>
                                    <c:otherwise>
                                        ${u.role}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.role eq 'customer'}">
                                        <button class="btn-sm btn-info view-history"
                                                data-id="${u.id}">
                                            <i class="fas fa-history"></i> Xem
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">--</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <label class="switch">
                                    <input type="checkbox"
                                        ${u.status ? "checked" : ""}
                                           onchange="window.toggleStatus(${u.id}, this.checked)">
                                    <span class="slider round"></span>
                                </label>
                            </td>
                            <td>
                                <c:if test="${currentUser == null || currentUser.id != u.id}">
                                    <button class="btn-icon edit-btn" onclick="editUser(${u.id})">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn-icon delete-btn" onclick="deleteUser(${u.id})">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </c:if>

                                <c:if test="${currentUser != null && currentUser.id == u.id}">
                                    <span class="text-muted">Bạn</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                </table>
            </div>
            <div class="pagination">

                <%-- Trước --%>
                <c:if test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}&search=${searchKeyword}&role=${filterRole}">
                        &laquo; Trước
                    </a>
                </c:if>

                <%-- Các trang --%>
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <a href="?page=${i}&search=${searchKeyword}&role=${filterRole}"
                       class="${i == currentPage ? 'active' : ''}">
                            ${i}
                    </a>
                </c:forEach>

                <%-- Sau --%>
                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}&search=${searchKeyword}&role=${filterRole}">
                        Sau &raquo;
                    </a>
                </c:if>

            </div>

        </main>
    </div>
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

<div id="user-modal" class="custom-modal-overlay">
    <div class="custom-modal-content">
        <span class="close-btn" onclick="closeUserModal()">&times;</span>
        <h3><span id="modal-title-user">Thêm</span> Người Dùng</h3>
        <form class="user-form"
              action="${pageContext.request.contextPath}/quan-ly-nguoi-dung"
              method="POST">

            <input type="hidden" name="action" id="formAction">
            <input type="hidden" id="userIdHidden" name="id" value="">
            <input type="hidden" name="page" value="${currentPage}">

            <div class="form-section left-col">
                <label for="userName">Họ và tên:</label>
                <input type="text" id="userName" name="userName" placeholder="Nguyễn Văn A" required>

                <label>Giới tính:</label>
                <div class="gender-group">
                    <label>
                        <input type="radio" name="gender" value="male"
                               <c:if test="${user.gender eq 'male'}">checked</c:if>> Nam

                    </label>

                    <label>
                        <input type="radio" name="gender" value="female"
                               <c:if test="${user.gender eq 'female'}">checked</c:if>> Nữ
                    </label>

                    <label>
                        <input type="radio" name="gender" value="other"
                               <c:if test="${user.gender eq 'other'}">checked</c:if>> Khác
                    </label>

                </div>
                <label for="dob">Ngày sinh:</label>
                <input
                        type="date"
                        id="dob"
                        name="birthday"
                        value="${user.birthday}">

                <label for="userEmail">Email:</label>
                <div class="input-group-custom">
                    <input type="email" id="userEmail" name="userEmail" placeholder="example@email.com" required>
                    <button type="button" id="btnSendOTP" class="btn-inline btn-send">Gửi mã</button>
                </div>

                <label for="userOTP">Mã xác thực OTP:</label>
                <div class="input-group-custom">
                    <input type="text" id="userOTP" name="userOTP" placeholder="Nhập mã OTP">
                    <button type="button" id="btnVerifyOTP" class="btn-inline btn-verify">Xác nhận</button>
                </div>

            </div>

            <div class="form-section right-col">
                <label for="userPhone">Số điện thoại:</label>
                <input type="tel" id="userPhone" name="userPhone" placeholder="0123456789"
                       pattern="[0-9]{10}" title="Số điện thoại phải có 10 chữ số" required>

                <label for="userRole">Phân quyền:</label>
                <select id="userRole" name="userRole" required>
                    <option value="">-- Chọn vai trò --</option>
                    <option value="customer">Khách hàng</option>
                    <option value="admin">Quản trị viên</option>
                </select>

                <label for="userPassword">Mật khẩu:</label>
                <input type="password" id="userPassword" name="userPassword"
                       placeholder="Nhập mật khẩu" autocomplete="new-password">

                <label for="userConfirmPassword">Xác nhận mật khẩu:</label>
                <input type="password" id="userConfirmPassword"
                       placeholder="Nhập lại mật khẩu" autocomplete="new-password">
            </div>

            <button type="submit" class="btn btn-primary submit-btn">
                Lưu Người Dùng
            </button>
        </form>

    </div>
</div>
<div id="historyModal" class="custom-modal-overlay">
    <div class="custom-modal-content large-modal">
        <div class="modal-header-history">
            <h3 class="modal-title">Lịch Sử Mua Hàng - ID: <span id="historyUserId">#001</span></h3>
            <span class="close-btn history-close-btn">&times;</span>
        </div>
        <div class="modal-body history-body">
            <div class="history-controls">
                <input type="text" placeholder="Tìm kiếm đơn hàng" class="search-input" id="historySearchInput"
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

            <div class="history-table-container">
                <table class="history-table">
                    <thead>
                    <tr>
                        <th>Mã ĐH</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái Đơn hàng</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>#${order.id}</td>
                            <td>
                                    ${order.created_at.hour < 10 ? '0' : ''}${order.created_at.hour}:${order.created_at.minute < 10 ? '0' : ''}${order.created_at.minute}
                                <br>
                                    ${order.created_at.dayOfMonth < 10 ? '0' : ''}${order.created_at.dayOfMonth}-${order.created_at.monthValue < 10 ? '0' : ''}${order.created_at.monthValue}-${order.created_at.year}
                            </td>
                            <td>
                                <fmt:formatNumber value="${order.total_price}" type="currency" currencySymbol="đ"
                                                  maxFractionDigits="0"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 'Chờ xác nhận'}">
            <span class="status-badge status-pending-bg">
                    ${order.status}
            </span>
                                    </c:when>
                                    <c:when test="${order.status == 'Đang giao'}">
            <span class="status-badge status-shipping-bg">
                    ${order.status}
            </span>
                                    </c:when>
                                    <c:when test="${order.status == 'Đã giao'}">
            <span class="status-badge status-delivered-bg">
                    ${order.status}
            </span>
                                    </c:when>
                                    <c:when test="${order.status == 'Đã hủy'}">
            <span class="status-badge status-cancelled-bg">
                    ${order.status}
            </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button class="btn-sm btn-action view-detail"
                                        data-id="${order.id}"
                                        data-status="${order.status}"
                                        data-date="${order.created_at}"
                                        data-customer="${order.user.name}"
                                        data-phone="${empty order.user.phone ? 'Chưa có' : order.user.phone}"
                                        data-address="${order.address.address}"
                                        data-total="<fmt:formatNumber value='${order.total_price}' type='currency' currencySymbol='đ' maxFractionDigits='0'/>">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="history-pagination">
            </div>
        </div>
    </div>
</div>
<div id="orderDetailModal" class="custom-modal-overlay">
    <div class="custom-modal-content large-modal">
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
                <div id="orderDetailBody">
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

<div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa người dùng này không? Hành động này không thể hoàn tác.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger" id="btnConfirmDelete">Xóa ngay</button>
            </div>
        </div>
    </div>
</div>
<div class="toast-container position-fixed top-0 start-50 p-3">
    <div id="appToast"
         class="toast align-items-center text-bg-info border-0"
         role="alert"
         aria-live="assertive"
         aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage">
                <!-- message -->
            </div>
            <button type="button"
                    class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"
                    aria-label="Close"></button>
        </div>
    </div>
</div>
<script>
    const CONTEXT_PATH = '<%= request.getContextPath() %>';
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_user.js"></script>
</body>
</html>