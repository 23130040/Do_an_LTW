
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_quan_ly_sp.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="product"/>
        </jsp:include>


        <!------------------- QUẢN LÝ SẢN PHẢM----------------->

        <main class="content">
            <h2 class="page-title">Quản Lý Sản Phẩm</h2>

            <div class="control-panel">
                <div class="filters">
                    <input type="text" placeholder="Tìm kiếm sản phẩm" class="search-input" id="searchInput"
                           value="${selectedSearch}">

                    <select name="category" class="filter-select" id="categoryFilter">
                        <option value="">-- Danh mục --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${cat.id == selectedCat ? 'selected' : ''}>
                                    ${cat.name}
                            </option>
                        </c:forEach>
                    </select>

                    <select name="origin" class="filter-select" id="originFilter">
                        <option value="">-- Nguồn gốc --</option>
                        <c:forEach var="org" items="${origin}">
                            <option value="${org.id}" ${org.id == selectedOrg ? 'selected' : ''}>
                                    ${org.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <button class="btn button-primary" onclick="openProductModal()">
                    <i class="fas fa-plus"></i> Thêm Sản phẩm Mới
                </button>
            </div>

            <div class="alert alert-warning" style="display: none;">
                <i class="fas fa-exclamation-triangle"></i> Có **5** sản phẩm sắp hết hàng. <a href="#">Xem chi tiết</a>
            </div>

            <div class="product-table-container">
                <table class="product-table">
                    <thead>
                    <tr>
                        <th>SKU</th>
                        <th>Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Danh mục</th>
                        <th>Nguồn gốc</th>
                        <th>Khối lượng</th>
                        <th>Giá (VND)</th>
                        <th class="inventory-col">Tồn kho</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="item" items="${items}">
                        <tr>
                            <td>${item.sku}</td>
                            <td>
                                <img src="${pageContext.request.contextPath}/images/${item.imageUrl}"
                                     alt="${item.name}" class="product-thumb">
                            </td>
                            <td>${item.name}</td>
                            <td>${item.categoryName}</td>
                            <td>${item.originName}</td>
                            <td>${item.unitName}</td>
                            <td>${item.price}</td>
                            <td class="inventory-col">
                                    ${item.current_stock}
                            </td>
                            <td>
                                <button type="button" class="btn-icon edit-btn" onclick="editProduct(${item.id})">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <button type="button" class="btn-icon delete-btn"
                                        onclick="deleteAndKeepPage(${item.id}, ${currentPage})">
                                    <i class="fas fa-trash-alt" ></i>
                                </button>
                            </td>
                        </tr>
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

<!------------------- THÊM SẢN PHẨM ----------------->
<div id="product-modal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeProductModal()">&times;</span>
        <h3><span id="modal-title-product">Thêm</span> Sản Phẩm</h3>
        <form class="product-form"
              action="quanlysanpham"
              method="post"
              enctype="multipart/form-data">
            <input type="hidden" name="action" id="formAction" value="addItem">
            <input type="hidden" name="productId" id="productId">
            <div class="form-section left-col">
                <label>Tên sản phẩm:</label>
                <input type="text" name="name"  placeholder="Tên sản phẩm" required>

                <label>Mô tả ngắn:</label>
                <textarea name="shortDescription" rows="3" placeholder="Mô tả ngắn gọn"></textarea>

                <label>Mô tả chi tiết:</label>
                <textarea name="longDescription" rows="5" placeholder="Mô tả chi tiết "></textarea>

                <label>Danh mục:</label>
                <select name="categoryId" required>
                    <option value="">Chọn loại thịt</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}">${cat.name}</option>
                    </c:forEach>
                </select>

                <label>Nguồn gốc:</label>
                <select name="originId" required>
                    <option value="">Chọn nguồn gốc</option>
                    <c:forEach var="org" items="${origin}">
                        <option value="${org.id}">${org.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-section right-col">
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="flex-grow: 1;">
                        <label>Khối lượng:</label>
                        <select id="weightSelect" name="unitId" required style="width: 100%; padding: 5px;">
                            <option value="">Chọn khối lượng</option>
                            <c:forEach var="u" items="${unitList}">
                                <option value="${u.id}">${u.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button type="button" onclick="removeSelectedWeight()"
                            style="margin-top: 20px; background: none; cursor: pointer; padding: 4px 8px;">
                        <i class="fas fa-trash"></i> Xóa mục này
                    </button>
                </div>

                <div style="margin-top: 15px;">
                    <input type="number" id="newWeight" placeholder="Nhập số gram (vd: 2000)">
                    <button type="button" onclick="addNewWeight()">Thêm mới</button>
                </div>

                <label>Giá gốc (VND):</label>
                <input type="number" name="price" id="price" placeholder="50000" required>

                <label>Giảm giá (%):</label>
                <input type="number" name="discount" id="discount" placeholder="20" value="0">

                <label>Giá bán (VND):</label>
                <input type="number"
                       name="finalPrice"
                       id="finalPrice"
                       readonly
                       placeholder="Tự động tính">


                <label>Mã sản phẩm(SKU):</label>
                <input type="text" placeholder="1001" name="sku">

                <div class="inventory-group">
                    <label>Ngưỡng cảnh báo:</label>
                    <input type="number" placeholder="5 (Cảnh báo khi <= 5)" name="minStock">
                </div>


                <label>Hình ảnh sản phẩm:</label>
                <div class="image-upload-container">
                    <label>Hình ảnh sản phẩm:</label>
                    <div class="image-upload-box" onclick="document.getElementById('imageInput').click()">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <p>Nhấn để chọn nhiều ảnh (Ảnh đầu là ảnh chính)</p>
                        <input type="file" id="imageInput" name="images" accept="image/*" multiple
                               style="display: none;" onchange="previewImages(this)">
                    </div>
                    <div id="imagePreviewContainer" class="image-preview-wrapper"></div>
                </div>
            </div>

            <button type="submit" class="btn button-primary submit-btn">Lưu Sản Phẩm</button>
        </form>
    </div>
</div>

</div>
</div>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_sp.js"></script>
</body>
</html>