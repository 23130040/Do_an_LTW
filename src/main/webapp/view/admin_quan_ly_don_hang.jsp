
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
    <jsp:include page="base/admin_header.jsp" />

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
                    <input type="text" placeholder="Tìm kiếm theo Mã đơn hàng, Tên KH, SĐT..." class="search-input">

                    <select name="status" class="filter-select">
                        <option value="">-- Trạng thái đơn --</option>
                        <option value="shipping">Chờ xác nhận</option>
                        <option value="shipping">Đang chẩn bị</option>
                        <option value="shipping">Đang giao hàng</option>
                        <option value="delivered">Đã giao hàng</option>
                        <option value="cancelled">Đã hủy</option>
                    </select>

                    <input type="date" class="filter-date" title="Lọc theo ngày đặt hàng">
                </div>

                <div class="export-actions">
                    <button class="btn btn-secondary">
                        <i class="fas fa-file-excel"></i> Xuất Excel
                    </button>
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
                    <tr>
                        <td>#101</td>
                        <td>Nguyễn A<br>0901xxxx89</td>
                        <td>20/11/2023</td>
                        <td>350,000đ</td>
                        <td><span class="">Đang giao hàng</span></td>
                        <td>
                            <button class="btn-sm btn-action view-detail" title="Xem chi tiết"><i
                                    class="fas fa-eye"></i></button>
                            <button class="btn-sm btn-info print-invoice" title="In hóa đơn"><i
                                    class="fas fa-print"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>#102</td>
                        <td>Lê Thị B<br>0902xxxx67</td>
                        <td>19/11/2025</td>
                        <td>780,000đ</td>
                        <td><span class="">Đang giao hàng</span></td>
                        <td>
                            <button class="btn-sm btn-action view-detail"><i class="fas fa-eye"></i></button>
                            <button class="btn-sm btn-info print-invoice" title="In hóa đơn"><i
                                    class="fas fa-print"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>#103</td>
                        <td>Phạm Văn C<br>0903xxxx45</td>
                        <td>15/11/2025</td>
                        <td>1,200,000đ</td>
                        <td><span class="">Đã giao hàng</span></td>
                        <td>
                            <button class="btn-sm btn-action view-detail"><i class="fas fa-eye"></i></button>
                            <button class="btn-sm btn-info print-invoice" title="In hóa đơn"><i
                                    class="fas fa-print"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>#104</td>
                        <td>Trần D<br>0904xxxx23</td>
                        <td>10/11/2025</td>
                        <td>450,000đ</td>
                        <td><span class="">Đã hủy</span></td>
                        <td>
                            <button class="btn-sm btn-action view-detail"><i class="fas fa-eye"></i></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
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
            <h3 class="modal-title">Chi Tiết Đơn Hàng <span id="modalOrderId">#101</span></h3>
            <span class="close-btn">&times;</span>
        </div>
        <div class="modal-body">
            <div class="summary-info">
                <div class="summary-item">
                    <p class="summary-label">Trạng thái Đơn hàng:</p>
                    <p id="modalOrderStatus" class="status-badge status-shipping">Đang giao hàng</p>
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
                    <p><strong>Địa chỉ Giao hàng:</strong> <span id="modalShippingAddress">123 Đường ABC, Phường X, Quận Y, TP.HCM</span>
                    </p>
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
                <h4 class="grand-total">Tổng thanh toán: <span id="modalGrandTotal">350,000đ</span></h4>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary close-btn-footer">Đóng</button>
            <button type="button" class="btn btn-primary"><i class="fas fa-print"></i> In Hóa Đơn</button>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_don_hang.js"></script>
</body>
</html>