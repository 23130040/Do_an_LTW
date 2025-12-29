
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
                    <input type="text" placeholder="Tìm kiếm sản phẩm" class="search-input">
                    <select name="category" class="filter-select" required>
                        <option value="">Chọn loại thịt</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}">${cat.name}</option>
                        </c:forEach>
                    </select>
                    <select name="origin" class="filter-select" required>
                        <option value="">Chọn nguồn gốc</option>
                        <c:forEach var="org" items="${origin}">
                            <option value="${org.id}">${org.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <button class="btn btn-primary" onclick="openProductModal()">
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
                        <th>Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Danh mục</th>
                        <th>Nguồn gốc</th>
                        <th>Giá (VND)</th>
                        <th class="inventory-col">Tồn kho</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><img src="https://amp.thucphamsachhd.com/uploads/files/2023/08/15/SP000157-PD00919-WEB_Than-Noi-Bo-My-Cat-Steak-1-.png" alt="Beef" class="product-thumb"></td>
                        <td>Thịt Bò Thăn Nội Cao Cấp (Mỹ)</td>
                        <td>Thịt Bò</td>
                        <td>Mỹ</td>
                        <td>250.000</td>
                        <td class="inventory-col low-stock">8 kg</td>
                        <td>
                            <button class="btn-icon edit-btn"><i class="fas fa-edit"></i></button>
                            <button class="btn-icon delete-btn"><i class="fas fa-trash-alt"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td><img src="https://binhdienonline.com/thumbs_size/product/2021_01/ba-chi/[550x550-cr]3-chi-53.jpg" alt="Pork" class="product-thumb"></td>
                        <td>Thịt Heo Ba Chỉ Thảo Mộc</td>
                        <td>Thịt Heo</td>
                        <td>Việt Nam</td>
                        <td>120.000</td>
                        <td class="inventory-col">150 kg</td>
                        <td>
                            <button class="btn-icon edit-btn"><i class="fas fa-edit"></i></button>
                            <button class="btn-icon delete-btn"><i class="fas fa-trash-alt"></i></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
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
        <form class="product-form">
            <div class="form-section left-col">
                <label>Tên sản phẩm:</label>
                <input type="text" placeholder="Tên sản phẩm" required>

                <label>Mô tả ngắn:</label>
                <textarea rows="3" placeholder="Mô tả ngắn gọn"></textarea>

                <label>Mô tả chi tiết:</label>
                <textarea rows="5" placeholder="Mô tả chi tiết "></textarea>

                <label>Danh mục:</label>
                <select name="category" required>
                    <option value="">Chọn loại thịt</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}">${cat.name}</option>
                    </c:forEach>
                </select>

                <label>Nguồn gốc:</label>
                <select name="origin" required>
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
                <label>Giá bán (VND):</label>
                <input type="number" placeholder="250000" required>

                <label>Giá gốc :</label>
                <input type="number" placeholder="50000">

                <label>Mã sản phẩm:</label>
                <input type="text" placeholder="1001">

                <div class="inventory-group">
                    <label>Tồn kho hiện tại:</label>
                    <input type="number" placeholder="Số lượng (kg/gói)" required>
                    <label>Ngưỡng cảnh báo:</label>
                    <input type="number" placeholder="5 (Cảnh báo khi <= 5)">
                </div>


                <label>Hình ảnh sản phẩm:</label>
                <div class="image-upload-box">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <p>Kéo thả ảnh hoặc **Nhấn để chọn**</p>
                </div>
            </div>

            <button type="submit" class="btn btn-primary submit-btn">Lưu Sản Phẩm</button>
        </form>
    </div>
</div>

</div>
</div>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_sp.js"></script>
</body>
</html>