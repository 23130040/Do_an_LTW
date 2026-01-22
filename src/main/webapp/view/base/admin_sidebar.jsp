
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="sidebar">
    <nav class="sidebar-nav">
        <ul>
            <li class="${param.active == 'statistic' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/view/admin_thong_ke.jsp">Thống kê và Phân tích</a>
            </li>

            <li class="${param.active == 'warehouse' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/quan-ly-kho">Quản lý kho</a>
            </li>

            <li class="${param.active == 'category' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/quan-ly-danh-muc">Quản lý danh mục và nguồn gốc</a>
            </li>

            <li class="${param.active == 'product' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/quan-ly-san-pham">Quản lý sản phẩm</a>
            </li>

            <li class="${param.active == 'user' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/quan-ly-nguoi-dung">Quản lý người dùng</a>
            </li>

            <li class="${param.active == 'order' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/quan-ly-don-hang">Quản lý đơn hàng</a>
            </li>

            <li class="${param.active == 'news' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/quan-ly-tin-tuc">Quản lý tin tức</a>
            </li>

            <li class="${param.active == 'feedback' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/quan-ly-danh-gia">Quản lý đánh giá và phản hồi</a>
            </li>

            <li class="${param.active == 'config' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/cau-hinh-he-thong">Cấu hình hệ thống</a>
            </li>
        </ul>
    </nav>
</aside>
