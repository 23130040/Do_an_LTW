
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cấu hình hệ thống</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin_cau_hinh_he_thong.css">

</head>
<body>
<div class="admin-container">
    <!---------------- Thanh menu ------------------->
    <jsp:include page="base/admin_header.jsp" />

    <!---------------- Side Bar ------------------->
    <div class="main-wrapper">
        <jsp:include page="base/admin_sidebar.jsp">
            <jsp:param name="active" value="config"/>
        </jsp:include>



        <main class="content">
            <h2 class="page-title">Cấu Hình Hệ Thống</h2>
            <c:if test="${param.status == 'success'}">
                <div id="success-alert" style="color: green; padding: 10px; border: 1px solid green; margin-bottom: 10px;">
                    Cập nhật cấu hình thành công!
                </div>
            </c:if>

            <div id="store-settings" class="tab-content active-tab">
                <div class="setting-card">
                    <form class="setting-form" action="cau-hinh-he-thong" method="POST">
                        <input type="hidden" name="action" value="save">
                        <input type="hidden" name="id" value="${config.id}">
                        <input type="hidden" name="logoUrl" id="logoUrl"
                               value="${config.logo_url}">

                        <div class="form-row">
                            <div class="form-group">
                                <label>Tên Cửa Hàng:</label>
                                <input type="text" name="webName" value="${config.name}" required>
                            </div>
                            <div class="form-group">
                                <label>Email Liên Hệ:</label>
                                <input type="email" name="email" value="${config.email}" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Hotline:</label>
                                <input type="tel" name="hotline" value="${config.hotline}">
                            </div>
                            <div class="form-group">
                                <label>Mã Số Thuế:</label>
                                <input type="text" name="taxCode" value="${config.tax_code}">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>Facebook :</label>
                                <input type="text" name="facebook" value="${config.facebook}">
                            </div>
                            <div class="form-group">
                                <label>Instagram:</label>
                                <input type="text" name="instagram" value="${config.instagram}">
                            </div>
                        </div>

                        <label>Địa Chỉ Chi Tiết:</label>
                        <textarea name="address" rows="3">${config.address}</textarea>
                        <label>Logo Hiện Tại:</label>
                        <div class="logo-preview-box">
                            <img id="logoPreview"
                                 src="${pageContext.request.contextPath}/${config.logo_url}"
                                 style="max-height:80px; display:${empty config.logo_url ? 'none' : 'block'}">
                            <button type="button" onclick="selectLogo()">Chọn logo</button>

                        </div>

                        <button type="submit" class="btn btn-primary submit-btn">Lưu Cấu Hình</button>
                    </form>
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
<script>
    window.APP_CONTEXT = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
<script src="${pageContext.request.contextPath}/JS/admin_cau_hinh_he_thong.js"></script>

<script>
    function selectLogo() {
        var finder = new CKFinder();
        finder.basePath = APP_CONTEXT + '/ckfinder/';
        finder.selectMultiple = false;

        finder.selectActionFunction = function (fileUrl) {
            // fileUrl: /images/Bo10.png

            const logoInput = document.getElementById("logoUrl");
            const preview = document.getElementById("logoPreview");

            logoInput.value = fileUrl;

            preview.src = APP_CONTEXT + fileUrl;
            preview.style.display = "block";
        };

        finder.popup();
    }

</script>



</body>
</html>