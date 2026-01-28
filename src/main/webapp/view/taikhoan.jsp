<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <div id="sidebar">
        <div class="sidebar header">
            <img src="${pageContext.request.contextPath}${empty user.avatar ? "/images/avatar.jpg" : user.avatar}" alt="avatar">
            <h3 class="username">${user.name}</h3>
        </div>
        <div class="sidebar menu">
            <a href="?tab=ho-so" data-tab="profile" class="default-link">Hồ sơ</a>
            <a href="?tab=dia-chi" data-tab="address">Địa chỉ</a>
            <a href="?tab=doi-mat-khau" data-tab="password">Đổi mật khẩu</a>
            <a href="?tab=cai-dat" data-tab="setting">Những thiết lập riêng tư</a>
        </div>
    </div>
    <div class="main-content">
        <div id="${requestScope.idContent}">
            <c:import url="${requestScope.pageContent}"/>
        </div>
    </div>
</div>