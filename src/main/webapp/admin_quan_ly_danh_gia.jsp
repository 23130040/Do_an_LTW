
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đánh giá và phản hồi</title>
    <link rel="stylesheet" href="CSS/admin_quan_ly_danh_gia.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="admin_sidebar.jsp">
            <jsp:param name="active" value="feedback"/>
        </jsp:include>

        <!---------------- QUẢN LÝ ĐÁNH GIÁ VÀ PHẢN HỒI ------------------->
        <main class="content">
            <h2 class="page-title">Quản Lý Đánh Giá và Phản Hồi</h2>

            <div class="control-panel">
                <div class="filters">
                    <input type="text" placeholder="Tìm kiếm theo Tên SP, Nội dung..." class="search-input">

                    <select name="rating" class="filter-select">
                        <option value="">-- Xếp hạng --</option>
                        <option value="5">5 Sao</option>
                        <option value="4">4 Sao</option>
                        <option value="3">3 Sao</option>
                        <option value="2">2 Sao</option>
                        <option value="1">1 Sao</option>
                    </select>

                    <select name="status" class="filter-select">
                        <option value="">-- Trạng thái --</option>
                        <option value="pending">Chờ duyệt</option>
                        <option value="approved">Đã duyệt</option>
                        <option value="hidden">Đã xóa</option>
                    </select>

                    <select name="type" class="filter-select">
                        <option value="">-- Loại --</option>
                        <option value="no-reply">Chưa trả lời</option>
                        <option value="spam">Đã trả lời</option>
                    </select>
                </div>

                <div class="summary-info">
                    <div class="total-reviews">Tổng: 10 đánh giá</div>
                    <div class="avg-rating">TB: <i class="fas fa-star text-warning"></i> 4/5</div>
                </div>
            </div>

            <div class="review-table-container">
                <table class="review-table">
                    <thead>
                    <tr>
                        <th>Ngày giờ</th>
                        <th>Sản phẩm</th>
                        <th>Khách hàng</th>
                        <th>Sao</th>
                        <th>Nội dung Đánh giá</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr class="highlight-row">
                        <td>10:30 <br>22/11/2023</td>
                        <td>Thịt Bò Thăn Nội Cao Cấp (Mỹ)</td>
                        <td>Nguyễn Văn A</td>
                        <td class="rating-stars">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star"></i>
                        </td>
                        <td>Sản phẩm tươi ngon, đóng gói cẩn thận. Giao hàng hơi lâu.</td>
                        <td><span class="status-badge status-pending">Chưa trả lời</span></td>
                        <td>
                            <button class="btn-sm btn-info reply-btn" title="Phản hồi lại"><i class="fas fa-reply"></i> Trả lời</button>
                            <button class="btn-sm btn-danger delete-btn" title="Xóa"><i class="fas fa-trash-alt"></i></button>
                        </td>
                    </tr>
                    <tr class="highlight-row">
                        <td>20:00<br>19/11/2023</td>
                        <td>Thịt Heo Ba Chỉ Thảo Mộc</td>
                        <td>Lê Thị B</td>
                        <td class="rating-stars">
                            <i class="fas fa-star text-warning"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </td>
                        <td>Thịt không tươi như quảng cáo, có mùi lạ. Yêu cầu xem xét. <span class="report-alert"></span></td>
                        <td><span class="status-badge status-pending">Chưa trả lời</span></td>
                        <td>
                            <button class="btn-sm btn-info reply-btn" title="Phản hồi lại"><i class="fas fa-reply"></i> Trả lời</button>
                            <button class="btn-sm btn-danger delete-btn" title="Xóa"><i class="fas fa-trash-alt"></i></button>
                        </td>
                    </tr>
                    <tr class="highlight-row">
                        <td>08:00<br>15/11/2023</td>
                        <td>Thịt Gà Ta Đùi</td>
                        <td>Phạm Văn C</td>
                        <td class="rating-stars">
                            <i class="fas fa-star text-warning"></i><i class="fas fa-star text-warning"></i><i class="fas fa-star text-warning"></i><i class="fas fa-star text-warning"></i><i class="fas fa-star text-warning"></i>
                        </td>
                        <td>Chất lượng tuyệt vời! Sẽ mua lại.</td>
                        <td><span class="status-badge status-replied">Đã trả lời</span></td>
                        <td>
                            <button class="btn-sm btn-danger delete-btn"><i class="fas fa-trash-alt"></i></button>
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
<div id="replyModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Phản Hồi Đánh Giá</h3>
            <span class="close-btn" onclick="closeReplyModal()">&times;</span>
        </div>
        <div class="modal-body">
            <div class="review-details">
                <p><strong>Khách hàng:</strong> <span id="modalCustomerName">Nguyễn Văn A</span></p>
                <p><strong>Sản phẩm:</strong> <span id="modalProductName">Thịt heo</span></p>
                <p><strong>Đánh giá:</strong> <span id="modalRatingStars">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                </span></p>
                <p class="review-date-meta">Ngày: <span id="modalReviewDate">20/11/2023</span></p>
            </div>

            <hr>

            <h4>Lịch Sử Phản Hồi</h4>
            <div class="chat-history" id="modalReplyHistory">
                <div class="history-item customer-review">
                    <p class="history-meta"><strong>Khách hàng</strong> - 22/11/2023</p>
                    <p class="history-text">Sản phẩm tươi ngon, đóng gói cẩn thận. Giao hàng hơi lâu.</p>
                </div>
                <div class="history-item admin-reply">
                    <p class="history-meta"><strong>Bạn (Admin)</strong> - 23/11/2023</p>
                    <p class="history-text">Cảm ơn bạn đã phản hồi! CleanMeat sẽ cải thiện dịch vụ giao hàng.</p>
                </div>
            </div>

            <div class="reply-input-area">
                <textarea id="replyInput" placeholder="Nhập phản hồi của bạn..."></textarea>
                <button id="sendReplyButton" class="btn-info"><i class="fas fa-paper-plane"></i> Gửi Phản Hồi</button>
            </div>
        </div>
    </div>
</div>
<script src="JS/admin_quan_ly_danh_gia.js"></script>
</body>
</html>