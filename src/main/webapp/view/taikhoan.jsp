<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <div id="sidebar">
        <div class="sidebar header">
            <img src="${pageContext.request.contextPath}/images/avatar.jpg" alt="avatar">
            <h3 class="username">Nguyễn Văn A</h3>
        </div>
        <div class="sidebar menu">
            <a href="${pageContext.request.contextPath}/ho-so" class="default-link">Hồ sơ</a>
            <a href="${pageContext.request.contextPath}/dia-chi">Địa chỉ</a>
            <a href="${pageContext.request.contextPath}/doi-mat-khau">Đổi mật khẩu</a>
            <a href="${pageContext.request.contextPath}/cai-dat">Những thiết lập riêng tư</a>
        </div>
    </div>

    <div class="main-content">
        <div id="${requestScope.idContent}">
            <c:import url="${requestScope.pageContent}" />
        </div>
    </div>
</div>