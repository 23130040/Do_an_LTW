
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="sidebar">
    <nav class="sidebar-nav">
        <ul>
            <li class="${param.active == 'statistic' ? 'active' : ''}">
                <a href="admin_thong_ke.jsp">Thống kê và Phân tích</a>
            </li>

            <li class="${param.active == 'warehouse' ? 'active' : ''}">
                <a href="admin_quan_ly_kho.jsp">Quản lý kho</a>
            </li>

            <li class="${param.active == 'category' ? 'active' : ''}">
                <a href="admin_quan_ly_danh_muc.jsp">Quản lý danh mục và nguồn gốc</a>
            </li>

            <li class="${param.active == 'product' ? 'active' : ''}">
                <a href="admin_quan_ly_sp.jsp">Quản lý sản phẩm</a>
            </li>

            <li class="${param.active == 'user' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/quanlyuser">Quản lý người dùng</a>
            </li>

            <li class="${param.active == 'order' ? 'active' : ''}">
                <a href="admin_quan_ly_don_hang.jsp">Quản lý đơn hàng</a>
            </li>

            <li class="${param.active == 'news' ? 'active' : ''}">
                <a href="admin_quan_ly_tin_tuc.jsp">Quản lý khuyến mãi và nội dung</a>
            </li>

            <li class="${param.active == 'feedback' ? 'active' : ''}">
                <a href="admin_quan_ly_danh_gia.jsp">Quản lý đánh giá và phản hồi</a>
            </li>

            <li class="${param.active == 'config' ? 'active' : ''}">
                <a href="admin_cau_hinh_he_thong.jsp">Cấu hình hệ thống</a>
            </li>
        </ul>
    </nav>
</aside>
