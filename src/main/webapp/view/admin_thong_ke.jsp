
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý thống kê và phân tích</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_thong_ke.css">
</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="statistic"/>
        </jsp:include>

        <main class="content">
            <h2 class="page-title">Tổng Quan Thống Kê</h2>

            <div class="kpi-row">
                <div class="kpi-card bg-red">
                    <div class="kpi-icon"><i class="fas fa-chart-line"></i></div>
                    <div class="kpi-info">
                        <span class="kpi-value">98.230.000₫</span>
                        <span class="kpi-label">Doanh Thu Tháng</span>
                    </div>
                </div>
                <div class="kpi-card bg-blue">
                    <div class="kpi-icon"><i class="fas fa-shopping-cart"></i></div>
                    <div class="kpi-info">
                        <span class="kpi-value">1,280</span>
                        <span class="kpi-label">Đơn Hàng Mới</span>
                    </div>
                </div>
                <div class="kpi-card bg-yellow">
                    <div class="kpi-icon"><i class="fas fa-user-plus"></i></div>
                    <div class="kpi-info">
                        <span class="kpi-value">2,500</span>
                        <span class="kpi-label">Khách Hàng Mới</span>
                    </div>
                </div>
                <div class="kpi-card bg-dark">
                    <div class="kpi-icon"><i class="fas fa-boxes"></i></div>
                    <div class="kpi-info">
                        <span class="kpi-value">45</span>
                        <span class="kpi-label">Mục Cần Nhập</span>
                    </div>
                </div>
            </div>


            <div class="widget-row full-width-widget">
                <div class="widget-card">
                    <h4><i class="fas fa-medal"></i> Top 5 Sản Phẩm Bán Chạy</h4>
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Sản Phẩm</th>
                            <th>Đã Bán</th>
                            <th>Doanh Thu</th>
                            <th>Tỷ Trọng (%)</th>
                            <th>Đánh Giá</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>Thịt Bò Thăn Nội Cao Cấp (Mỹ)</td>
                            <td>952</td>
                            <td>238M</td>
                            <td>25.1%</td> <td>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </td> </tr>
                        <tr>
                            <td>Thịt Heo Ba Chỉ Thảo Mộc</td>
                            <td>1,280</td>
                            <td>153M</td>
                            <td>16.2%</td> <td>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </td> </tr>
                        <tr>
                            <td>Thịt Gà Ta Organic</td>
                            <td>788</td>
                            <td>95M</td>
                            <td>10.0%</td> <td>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                            <i class="far fa-star"></i>
                        </td> </tr>
                        <tr>
                            <td>Cá Hồi Fillet Na Uy</td>
                            <td>604</td>
                            <td>181M</td>
                            <td>19.1%</td> <td>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </td> </tr>
                        <tr>
                            <td>Gân Bò Úc Tươi</td>
                            <td>1,010</td>
                            <td>120M</td>
                            <td>12.7%</td> <td>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="far fa-star"></i>
                        </td> </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="widget-row two-cols">
                <div class="widget-card">
                    <h4><i class="fas fa-clipboard-list"></i> Trạng Thái Đơn Hàng</h4>
                    <ul class="order-status-list">
                        <li>
                            <i class="fas fa-circle status-pending"></i>
                            Chờ Xác Nhận: <span>25 Đơn</span>
                        </li>
                        <li>
                            <i class="fas fa-circle status-processing"></i>
                            Đang Chuẩn Bị: <span>50 Đơn</span>
                        </li>
                        <li>
                            <i class="fas fa-circle status-shipped"></i>
                            Đang Giao Hàng: <span>120 Đơn</span>
                        </li>
                        <li>
                            <i class="fas fa-circle status-completed"></i>
                            Đã Giao Hàng: <span>1,085 Đơn</span>
                        </li>
                        <li>
                            <i class="fas fa-circle status-cancelled"></i>
                            Đã Hủy: <span>15 Đơn</span>
                        </li>
                    </ul>
                </div>

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
<script src="${pageContext.request.contextPath}/JS/admin_thong_ke.js"></script>
</body>
</html>