<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý kho</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_quan_ly_kho.css">

</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp"/>

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="warehouse"/>
        </jsp:include>

        <main class="content">
            <h2 class="page-title">Quản Lý Kho</h2>

            <div class="tab-nav">
                <button class="tab-link" onclick="openTab(event, 'input_history')">Lịch Sử Nhập Kho</button>
                <button class="tab-link" onclick="openTab(event, 'output_history')">Lịch Sử Xuất Kho</button>
            </div>

            <div id="input_history" class="tab-content" style="display: block;">
                <div class="control-panel history-panel">
                    <div class="filters">
                        <input type="text" placeholder="Tìm kiếm theo Mã SP, Người tạo..." class="search-input"
                               style="width: 300px;">
                        <select name="category" class="filter-select">
                            <option value="">-- Danh mục --</option>
                            <option value="ThitBo">Thịt Bò</option>
                            <option value="ThitHeo">Thịt Heo</option>
                            <option value="ThitGa">Thịt Gà</option>
                        </select>
                        <select name="origin" class="filter-select">
                            <option value="">-- Nguồn gốc --</option>
                            <option value="VietNam">Việt Nam</option>
                            <option value="My">Mỹ</option>
                            <option value="Uc">Úc</option>
                        </select>
                    </div>
                    <button class="btn btn-primary" onclick="openStockModal('input')">
                        <i class="fas fa-plus-circle"></i> Tạo Phiếu Nhập
                    </button>
                </div>

                <div class="history-table-container">
                    <table class="history-table">
                        <thead>
                        <tr>
                            <th>Mã Phiếu</th><th>Thời gian</th><th>Danh mục</th>
                            <th>Sản phẩm</th><th>Nguồn gốc</th><th>Khối lượng</th>
                            <th>Loại</th><th>Số lượng</th><th>Người tạo</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="s" items="${stockList}">
                            <c:if test="${s.type == 'Nhap'}">
                                <tr>
                                    <td>${s.id}</td>
                                    <td>${s.created_at}</td>
                                    <td>${s.item.categoryName}</td>
                                    <td>${s.item.name}</td>
                                    <td>${s.item.originName}</td>
                                    <td>${s.item.unitName}</td>
                                    <td><span class="type-badge type-input">
                                            ${s.type == 'Nhap' ? 'Nhập' : s.type}
                                    </span></td>
                                    <td>+${s.quantity}</td>
                                    <td>${s.created_by.name}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}">&laquo; Trước</a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="?page=${i}"
                           class="${i == currentPage ? 'active' : ''}">
                                ${i}
                        </a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}">Sau &raquo;</a>
                    </c:if>
                </div>
            </div>

            <div id="output_history" class="tab-content" style="display: none;">
                <div class="control-panel history-panel">
                    <div class="filters">
                        <input type="text" placeholder="Tìm kiếm theo Mã SP, Người tạo..." class="search-input"
                               style="width: 300px;">
                        <select name="category" class="filter-select">
                            <option value="">-- Danh mục --</option>
                            <option value="ThitBo">Thịt Bò</option>
                            <option value="ThitHeo">Thịt Heo</option>
                            <option value="ThitGa">Thịt Gà</option>
                        </select>
                        <select name="origin" class="filter-select">
                            <option value="">-- Nguồn gốc --</option>
                            <option value="VietNam">Việt Nam</option>
                            <option value="My">Mỹ</option>
                            <option value="Uc">Úc</option>
                        </select>
                    </div>
                    <button class="btn btn-primary btn-secondary" onclick="openStockModal('output')">
                        <i class="fas fa-minus-circle"></i> Tạo Phiếu Xuất
                    </button>
                </div>

                <div class="history-table-container">
                    <table class="history-table">
                        <thead>
                        <tr>
                            <th>Mã Phiếu</th><th>Thời gian</th><th>Danh mục</th>
                            <th>Sản phẩm</th><th>Nguồn gốc</th><th>Khối lượng</th>
                            <th>Loại</th><th>Số lượng</th><th>Người tạo</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="s" items="${stockList}">
                            <c:if test="${s.type == 'Xuat'}">
                                <tr>
                                    <td>${s.id}</td>
                                    <td>${s.created_at}</td>
                                    <td>${s.item.categoryName}</td>
                                    <td>${s.item.name}</td>
                                    <td>${s.item.originName}</td>
                                    <td>${s.item.unitName}</td>
                                    <td><span class="type-badge type-output">
                                            ${s.type == 'Xuat' ? 'Xuất' : s.type}
                                    </span></td>
                                    <td>-${s.quantity}</td>
                                    <td>${s.created_by.name}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}">&laquo; Trước</a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="?page=${i}"
                           class="${i == currentPage ? 'active' : ''}">
                                ${i}
                        </a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}">Sau &raquo;</a>
                    </c:if>
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
<div id="stockAdjustmentModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title" id="stockModalTitle">Tạo Phiếu Nhập Kho</h3>
            <span class="close-btn" onclick="closeStockModal()">&times;</span>
        </div>

        <div class="modal-body">
            <form id="stockForm" action="quanlykho" method="post">
                <div class="form-group">
                    <label for="product_id">Sản phẩm:</label>
                    <select name="item" id="item_id" class="filter-select select2-enable" required>
                        <option value="">-- Tìm theo SKU hoặc Tên sản phẩm --</option>
                        <c:forEach var="it" items="${items}">
                            <option value="${it.id}">
                                    ${it.sku} - ${it.name} (${it.originName}) - Khối lượng : ${it.unitName} - Tồn: ${it.current_stock}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group half-width">
                        <label for="type">Loại giao dịch :</label>
                        <select name ="type" id="type" required>
                            <option value="">-- Chọn loại --</option>
                            <option value="Nhap">Nhập Hàng (Tăng kho)</option>
                            <option value="Xuat">Xuất Hủy (Giảm kho)</option>
                        </select>
                    </div>

                    <div class="form-group half-width">
                        <label for="quantity">Số lượng :</label>
                        <input name="quantity" type="number" id="quantity" placeholder="Nhập số lượng" required min="1">
                    </div>
                </div>

                <div class="form-group">
                    <label for="created_by">Người thực hiện:</label>
                    <input type="text" id="created_by" value="${sessionScope.user.name}" readonly>
                </div>

                <button type="submit" class="btn btn-primary submit-btn">Lưu Phiếu</button>
            </form>
        </div>
    </div>
</div>
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_kho.js"></script>
<script>
    $(document).ready(function() {
        $('.select2-enable').select2({
            placeholder: "-- Gõ mã SKU hoặc tên sản phẩm --",
            allowClear: true,
            width: '100%',
            dropdownParent: $('#stockAdjustmentModal')
        });
    });
</script>
</body>
</html>