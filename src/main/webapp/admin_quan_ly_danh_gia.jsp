<%@ page import="vn.edu.hcmuaf.fit.do_an_ltw.dao.FeedbackDAO" %>
<%@ page import="vn.edu.hcmuaf.fit.do_an_ltw.model.Feedback" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    DateTimeFormatter localTimeFmt = DateTimeFormatter.ofPattern("HH:mm");
    DateTimeFormatter localDateFmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    request.setAttribute("localTimeFmt", localTimeFmt);
    request.setAttribute("localDateFmt", localDateFmt);
%>
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
                    <input type="text" placeholder="Tìm kiếm..." class="search-input" id="searchInput" value="${keyword}">

                    <select name="rating" class="filter-select" id="rateFilter">
                        <option value="">-- Xếp hạng --</option>
                        <option value="5" ${selectedRate == '5' ? 'selected' : ''}>5 Sao</option>
                        <option value="4" ${selectedRate == '4' ? 'selected' : ''}>4 Sao</option>
                        <option value="3" ${selectedRate == '3' ? 'selected' : ''}>3 Sao</option>
                        <option value="2" ${selectedRate == '2' ? 'selected' : ''}>2 Sao</option>
                        <option value="1" ${selectedRate == '1' ? 'selected' : ''}>1 Sao</option>
                    </select>

                    <select name="type" class="filter-select" id="typeFilter">
                        <option value="">-- Loại --</option>
                        <option value="no-reply" ${selectedType == 'no-reply' ? 'selected' : ''}>Chưa trả lời</option>
                        <option value="replied" ${selectedType == 'replied' ? 'selected' : ''}>Đã trả lời</option>
                    </select>
                </div>

                <div class="summary-info">
                    <div class="total-reviews">Tổng: ${totalReviews} đánh giá</div>
                    <div class="avg-rating">TB: <i class="fas fa-star text-warning"></i> ${avgRating}/5</div>
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

                    <c:forEach var="f" items="${feedbackList}">
                        <c:set var="isReplied" value="${f.replied}"/>
                        <c:set var="statusClass"
                               value="${isReplied ? 'status-replied' : 'status-pending'}"/>
                        <c:set var="statusText"
                               value="${isReplied ? 'Đã trả lời' : 'Chưa trả lời'}"/>


                        <tr class="highlight-row">
                            <td>
                                <%
                                    Feedback feedbackItem = (Feedback) pageContext.findAttribute("f");

                                    DateTimeFormatter timeFmt = (DateTimeFormatter) request.getAttribute("localTimeFmt");
                                    DateTimeFormatter dateFmt = (DateTimeFormatter) request.getAttribute("localDateFmt");

                                    if (feedbackItem != null && feedbackItem.getCreated_at() != null) {
                                        LocalDateTime createdAt = feedbackItem.getCreated_at();
                                %>
                                <%= createdAt.format(timeFmt) %><br>
                                <%= createdAt.format(dateFmt) %>
                                <%  } else { %>
                                --:--
                                <%  } %>
                            </td>

                            <td> ${f.item_id_raw}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${f.user != null}">
                                        ${f.user.name}
                                    </c:when>
                                    <c:otherwise>
                                        *Khách hàng ẩn*
                                    </c:otherwise>
                                </c:choose>
                            </td>



                            <td class="rating-stars">
                                <c:forEach begin="1" end="${f.rating}" var="star">
                                    <i class="fas fa-star text-warning"></i>
                                </c:forEach>
                                <c:forEach begin="${f.rating + 1}" end="5" var="star">
                                    <i class="fas fa-star"></i>
                                </c:forEach>
                            </td>
                            <td>${f.comment}</td>
                            <td><span class="status-badge ${statusClass}">${statusText}</span></td>
                            <td>
                                <button class="btn-sm btn-info reply-btn"
                                        onclick="openReplyModal(${f.id}, ${f.user.id}, '${f.user.name}', '${f.item_id_raw}', ${f.rating}, '${createdAt.format(dateFmt)}')">
                                        ${isReplied ? '<i class="fa-solid fa-eye"></i> Xem' : '<i class="fas fa-reply"></i> Trả lời'}
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
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
                <p><strong>Khách hàng:</strong> <span id="modalCustomerName"></span></p>
                <p><strong>Sản phẩm:</strong> <span id="modalProductName"></span></p>
                <p><strong>Đánh giá:</strong> <span id="modalRatingStars"></span></p>
                <p class="review-date-meta">Ngày: <span id="modalReviewDate"></span></p>
            </div>

            <hr>

            <h4>Lịch Sử Phản Hồi</h4>
            <div class="chat-history" id="modalReplyHistory">
                <div class="history-item customer-review">
                    <p class="history-meta"><strong>Khách hàng</strong> - 22/11/2023</p>
                    <p class="history-text">Sản phẩm tươi ngon, đóng gói cẩn thận. Giao hàng hơi lâu.</p>
                </div>
                <div class="history-item admin-reply">
                    <p class="history-meta"><strong>Bạn</strong> - 23/11/2023</p>
                    <p class="history-text">Cảm ơn bạn đã phản hồi! CleanMeat sẽ cải thiện dịch vụ giao hàng.</p>
                </div>
            </div>

            <div class="reply-input-area">
                <label for="replyInput" class="visually-hidden">Phản hồi</label>
                <textarea id="replyInput" placeholder="Nhập phản hồi của bạn..."></textarea>
                <button id="sendReplyButton" class="btn-info"><i class="fas fa-paper-plane"></i> Gửi Phản Hồi</button>
            </div>
        </div>
    </div>
</div>
<script src="JS/admin_quan_ly_danh_gia.js"></script>
</body>
</html>