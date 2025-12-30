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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_quan_ly_user.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp" />

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
                <table class="user-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Thông tin liên hệ</th>
                        <th>Phân quyền</th>
                        <th>Lịch sử mua hàng</th>
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
                            <td>—</td>
                            <td>
                                <button class="btn-icon edit-btn" onclick="editUser(${u.id})"><i class="fas fa-edit"></i></button>
                                <button class="btn-icon delete-btn" onclick="deleteUser(${u.id})"><i class="fas fa-trash-alt"></i></button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>

                </table>
            </div>
            <c:if test="${noOfPages > 1}">
                <div class="pagination-container" style="margin-top: 20px; display: flex; justify-content: space-between; align-items: center;">
                    <div style="font-size: 0.9em; color: #777;">
                        Đang hiển thị ${fn:length(users)} trên tổng số ${noOfRecords} người dùng.
                    </div>
                    <nav>
                        <ul class="pagination" style="display: inline-flex; list-style: none; padding: 0;">

                                <%-- Nút trang trước --%>
                            <c:if test="${currentPage > 1}">
                                <li class="page-item" style="margin-right: 5px;">
                                    <a class="page-link btn btn-secondary" href="?page=${currentPage - 1}" style="padding: 6px 12px; text-decoration: none;">&laquo; Trước</a>
                                </li>
                            </c:if>

                                <%-- Hiển thị các trang --%>
                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                <li class="page-item" style="margin-right: 5px;">
                                    <a class="page-link ${currentPage == i ? 'btn-primary' : 'btn-secondary'}" href="?page=${i}"
                                       style="padding: 6px 12px; text-decoration: none; border-radius: 3px; background-color: ${currentPage == i ? '#8d2a3a' : '#f0f0f0'}; color: ${currentPage == i ? '#fff' : '#333'}; border: 1px solid ${currentPage == i ? '#8d2a3a' : '#ddd'};">
                                            ${i}
                                    </a>
                                </li>
                            </c:forEach>

                                <%-- Nút trang sau --%>
                            <c:if test="${currentPage < noOfPages}">
                                <li class="page-item">
                                    <a class="page-link btn btn-secondary" href="?page=${currentPage + 1}" style="padding: 6px 12px; text-decoration: none;">Sau &raquo;</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </c:if>
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

<div id="user-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeUserModal()">&times;</span>
        <h3><span id="modal-title-user">Thêm</span> Người Dùng</h3>
        <form class="user-form"
              action="${pageContext.request.contextPath}/quanlyuser"
              method="POST">

            <input type="hidden" id="userIdHidden" name="id" value="">
            <input type="hidden" name="action" value="add">

            <div class="form-section left-col">
                <label for="userName">Họ và tên:</label>
                <input type="text" id="userName" name="userName" placeholder="Nguyễn Văn A" required>

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

                <label for="userPhone">Số điện thoại:</label>
                <input type="tel" id="userPhone" name="userPhone" placeholder="0123456789"
                       pattern="[0-9]{10}" title="Số điện thoại phải có 10 chữ số" required>
            </div>

            <div class="form-section right-col">
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
<div id="historyModal" class="modal">
    <div class="modal-content large-modal">
        <div class="modal-header-history">
            <h3 class="modal-title">Lịch Sử Mua Hàng - ID: <span id="historyUserId">#001</span></h3>
            <span class="close-btn history-close-btn">&times;</span>
        </div>
        <div class="modal-body history-body">
            <div class="history-controls">
                <input type="text" placeholder="Tìm kiếm theo Mã ĐH..." class="history-search-input">
                <select class="history-filter-select">
                    <option value="">-- Trạng thái đơn --</option>
                    <option value="delivered">Đã giao hàng</option>
                    <option value="cancelled">Đã hủy</option>
                </select>
                <input type="date" class="history-filter-date" title="Lọc theo ngày đặt hàng">
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
                    <tbody id="historyOrderList">
                    <tr>
                        <td>#1001</td>
                        <td>15/10/2025</td>
                        <td>450,000đ</td>
                        <td><span class="status-badge status-delivered">Đã giao hàng</span></td>
                        <td><button class="btn-sm btn-action view-detail" title="Xem chi tiết đơn"><i class="fas fa-eye"></i></button></td>
                    </tr>
                    <tr>
                        <td>#1002</td>
                        <td>01/11/2025</td>
                        <td>1,200,000đ</td>
                        <td><span class="status-badge status-cancelled">Đã hủy</span></td>
                        <td><button class="btn-sm btn-action view-detail" title="Xem chi tiết đơn"><i class="fas fa-eye"></i></button></td>
                    </tr>
                    <tr>
                        <td>#1003</td>
                        <td>10/11/2025</td>
                        <td>75,000đ</td>
                        <td><span class="status-badge status-delivered">Đã giao hàng</span></td>
                        <td><button class="btn-sm btn-action view-detail" title="Xem chi tiết đơn"><i class="fas fa-eye"></i></button></td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="history-pagination">
            </div>
        </div>
    </div>
</div>
<div id="orderDetailModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Chi Tiết Đơn Hàng <span id="modalOrderId">#101</span></h3>
            <span class="close-btn">&times;</span>
        </div>
        <div class="modal-body">
            <div class="summary-info">
                <div class="summary-item">
                    <p class="summary-label">Trạng thái Đơn hàng:</p>
                    <p id="modalOrderStatus" class="status-badge status-pending">Chờ xác nhận</p>
                </div>
                <div class="summary-item">
                    <p class="summary-label">Trạng thái Thanh toán:</p>
                    <p id="modalPaymentStatus" class="status-badge status-unpaid">Chưa thanh toán</p>
                </div>
                <div class="summary-item">
                    <p class="summary-label">Ngày đặt:</p>
                    <p id="modalOrderDate">20/11/2023</p>
                </div>
            </div>

            <div class="section-container">
                <h4><i class="fas fa-user"></i> Thông tin Khách hàng & Giao hàng</h4>
                <div class="info-grid">
                    <p><strong>Khách hàng:</strong> <span id="modalCustomerName">Nguyễn A</span></p>
                    <p><strong>Điện thoại:</strong> <span id="modalCustomerPhone">0901xxxx89</span></p>
                    <p><strong>Địa chỉ Giao hàng:</strong> <span id="modalShippingAddress">123 Đường ABC, Phường X, Quận Y, TP.HCM</span></p>
                    <p><strong>Phương thức vận chuyển:</strong> <span id="modalShippingMethod">Standard</span></p>
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
                    <tr>
                        <td>Thịt Bò Thăn Nội (300g)</td>
                        <td>200,000đ</td>
                        <td>1</td>
                        <td>200,000đ</td>
                    </tr>
                    <tr>
                        <td>Thịt Heo Ba Chỉ (500g)</td>
                        <td>150,000đ</td>
                        <td>1</td>
                        <td>150,000đ</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="total-summary">
                <p>Phụ phí (Shipping): <span>0đ</span></p>
                <p>Mã giảm giá (Discount): <span>-0đ</span></p>
                <h4 class="grand-total">Tổng thanh toán: <span id="modalGrandTotal">350,000đ</span></h4>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary close-btn-footer">Đóng</button>
            <button type="button" class="btn btn-primary"><i class="fas fa-print"></i> In Hóa Đơn</button>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_user.js"></script>
</body>
</html>