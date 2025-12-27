
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục và nguồn gốc</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_quan_ly_danh_muc.css">
</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="category"/>
        </jsp:include>

        <main class="content-area">
            <h2><i class="fas fa-sitemap"></i> Quản lý Danh mục và Nguồn gốc</h2>

            <div class="tab-container">
                <div class="tab-links">
                    <button class="tab-link ${activeTab == 'QuanLyDanhMuc' ? 'active' : ''}"
                            onclick="openTab(event, 'QuanLyDanhMuc')">
                        <i class="fas fa-tags"></i> Quản lý Danh mục
                    </button>
                    <button class="tab-link ${activeTab == 'QuanLyNguonGoc' ? 'active' : ''}"
                            onclick="openTab(event, 'QuanLyNguonGoc')">
                        <i class="fas fa-globe-asia"></i> Quản lý Nguồn gốc
                    </button>
                </div>

                <div id="QuanLyDanhMuc" class="tab-content ${activeTab == 'QuanLyDanhMuc' ? 'active' : ''}"
                     style="display: ${activeTab == 'QuanLyDanhMuc' ? 'block' : 'none'}">
                    <div class="card">
                        <div class="card-header">
                            <h3>Danh mục sản phẩm (Thịt heo, Thịt bò,...)</h3>
                            <button class="btn-add" onclick="openModal('addCategoryModal')"><i class="fas fa-plus"></i> Thêm Danh mục</button>
                        </div>
                        <div class="card-body">
                            <table>
                                <thead>
                                <tr>
                                    <th>Mã DM</th>
                                    <th>Tên Danh mục</th>
                                    <th>Tổng SP</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="cat" items="${categories}">
                                    <tr>
                                        <td>DM${cat.id}</td>
                                        <td>${cat.name}</td>
                                        <td>0</td> <td>
                                        <button class="btn-edit" onclick="editCategory(${cat.id})"><i class="fas fa-edit"></i></button>
                                        <button class="btn-delete" onclick="deleteCategory(${cat.id})"><i class="fas fa-trash"></i></button>
                                    </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>

                <div id="QuanLyNguonGoc" class="tab-content ${activeTab == 'QuanLyNguonGoc' ? 'active' : ''}"
                     style="display: ${activeTab == 'QuanLyNguonGoc' ? 'block' : 'none'}">
                    <div class="card">
                        <div class="card-header">
                            <h3>Nguồn gốc sản phẩm (Việt Nam, Mỹ, Úc,...)</h3>
                            <button class="btn-add" onclick="openModal('addOriginModal')"><i class="fas fa-plus"></i> Thêm Nguồn gốc</button>
                        </div>
                        <div class="card-body">
                            <table>
                                <thead>
                                <tr>
                                    <th>Mã NG</th>
                                    <th>Tên Nguồn gốc</th>
                                    <th>Tổng SP</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="org" items="${origin}">
                                    <tr>
                                        <td>DM${org.id}</td>
                                        <td>${org.name}</td>
                                        <td>0</td> <td>
                                        <button class="btn-edit" onclick="editOrigin(${org.id})"><i class="fas fa-edit"></i></button>
                                        <button class="btn-delete" onclick="deleteOrigin(${org.id})"><i class="fas fa-trash"></i></button>
                                    </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>


                </div>
            </div>
        </main>

    </div>

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
<div id="addCategoryModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-tags"></i> Thêm Danh mục Sản phẩm</h3>
            <span class="close-btn" onclick="closeModal('addCategoryModal')">&times;</span>
        </div>
        <div class="modal-body">
            <form>
                <div class="form-group">
                    <label for="categoryName">Tên Danh mục:</label>
                    <input type="text" id="categoryName" name="categoryName" required placeholder="Ví dụ: Thịt Heo Tươi">
                </div>
                <div class="form-group">
                    <label for="categoryDescription">Mô tả (Tùy chọn):</label>
                    <textarea id="categoryDescription" name="categoryDescription" rows="3" placeholder="Mô tả ngắn về danh mục này"></textarea>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-save"><i class="fas fa-plus"></i> Thêm mới</button>
                    <button type="button" class="btn-cancel" onclick="closeModal('addCategoryModal')">Đóng</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="addOriginModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3><i class="fas fa-globe-asia"></i> Thêm Nguồn gốc Sản phẩm</h3>
            <span class="close-btn" onclick="closeModal('addOriginModal')">&times;</span>
        </div>
        <div class="modal-body">
            <form>
                <div class="form-group">
                    <label for="originName">Tên Nguồn gốc:</label>
                    <input type="text" id="originName" name="originName" required placeholder="Ví dụ: Việt Nam">
                </div>
                <div class="form-group">
                    <label for="originCode">Mã Nguồn gốc (Tùy chọn):</label>
                    <input type="text" id="originCode" name="originCode" placeholder="Ví dụ: VN, US, AU">
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-save"><i class="fas fa-plus"></i> Thêm mới</button>
                    <button type="button" class="btn-cancel" onclick="closeModal('addOriginModal')">Đóng</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/JS/admin_quan_ly_danh_muc.js"></script>
</body>
</html>
