
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý tin tức</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_quan_ly_tin_tuc.css">
</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="news"/>
        </jsp:include>

        <!---------------- QUẢN LÝ KHUYẾN MÃI ------------------->
        <main class="content">
            <h2 class="page-title">Quản Lý Tin Tức</h2>
            <div id="content">
                <div class="content-section">
                    <div class="control-panel">
                        <div class="filters">
                            <input type="text" placeholder="Tìm kiếm theo tiêu đề" class="search-input">
                            <input type="date" class="filter-date" title="Lọc theo ngày đăng">
                        </div>
                        <button class="btn btn-primary" onclick="openAddArticleModal()"><i class="fas fa-plus"></i> Tạo Bài viết Mới</button>
                    </div>

                    <table class="article-table">
                        <thead>
                        <tr>
                            <th>Tiêu đề</th>
                            <th>Tác giả</th>
                            <th>Ngày đăng</th>
                            <th>Lượt xem</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="news" items="${newsList}">
                            <tr>
                                <td>${news.title}</td>
                                <td>${news.author}</td>
                                <td>${news.created_at}</td>
                                <td>1250</td> <td>
                <span class="status-badge ${news.status == 'Đã đăng' ? 'status-active' : 'status-draft'}">
                        ${news.status}
                </span>
                            </td>
                                <td>
                                    <a href="edit-news?id=${news.id}" class="btn-icon edit-btn"><i class="fas fa-edit"></i></a>
                                    <a href="delete-news?id=${news.id}" class="btn-icon delete-btn" onclick="return confirm('Are you sure?')">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
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

    <div id="article-modal" class="modal">
        <div class="modal-content large-modal">
            <span class="close-btn" onclick="closeModal('article-modal')">&times;</span>
            <h3><span id="modal-title-article">Tạo</span> Bài Viết Mới</h3>
            <form class="article-form">
                <div class="form-section full-col">
                    <label>Tiêu đề bài viết:</label>
                    <input type="text" placeholder="Ví dụ: Lợi ích của thịt bò Úc nhập khẩu" required>

                    <label>Tác giả:</label>
                    <input type="text" placeholder="Admin" readonly>

                    <label>Ảnh đại diện (Thumbnail):</label>
                    <div class="image-upload-box small-upload-box">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <p>Kéo thả ảnh hoặc **Nhấn để chọn**</p>
                    </div>

                    <label>Nội dung chi tiết:</label>
                    <textarea rows="10" placeholder="Nhập nội dung bài viết chi tiết..." required></textarea>

                    <label>Trạng thái:</label>
                    <select required>
                        <option value="draft">Bản nháp</option>
                        <option value="published">Đã đăng</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary submit-btn">Lưu Bài Viết</button>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_tin_tuc.js"></script>
</body>
</html>