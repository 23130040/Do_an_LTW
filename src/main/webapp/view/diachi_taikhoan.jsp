<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<div id="address-content" class="tab-content hidden">--%>
<form action="${pageContext.request.contextPath}/tai-khoan" method="post">
    <div class="address-content header">
        <div class="header-left">
            <h1 class="txt big">ĐỊA CHỈ CỦA TÔI</h1>
        </div>
        <div class="header-right">
            <button class="add-address-button" id="open-add-address-modal">+ Thêm địa chỉ mới</button>
        </div>
    </div>
    <div class="address-content body">
        <div class="address-content content" >
            <c:choose>
                <c:when test="${not empty addresses}">
                    <c:forEach var="addr" items="${addresses}">
                        <div class="address ${addr.defaultAddress ? 'default' : ''}">
                            <p class="address-detail">
                                    ${addr.address}
                            </p>
                            <button class="default-btn" ${addr.defaultAddress ? 'disabled' : ''}
                                    data-id="${addr.id}">Đặt mặc định
                            </button>
                            <button class="trash" aria-label="Xóa địa chỉ" data-id="${addr.id}"><i
                                    class="fa-solid fa-trash"></i>
                            </button>
                            <button class="edit open-change-address-modal" aria-label="Sửa địa chỉ"
                                    data-id="${addr.id}"><i
                                    class="fa-solid fa-pen-to-square"></i>
                            </button>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="empty-classes">
                        Chưa có địa chỉ nào. Hãy thêm địa chỉ mới.
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div id="address-modal" class="modal">
        <div class="modal-content">
            <span class="close-btn" id="close-change-address-modal">&times;</span>
            <div class="address-form">
                <h2 id="header-address"></h2>
                <div class="form-row">
                    <div class="form-group half-width">
                        <label for="province">Tỉnh/Thành phố (*)</label>
                        <select id="province" name="province" required>
                            <option value="">Chọn Tỉnh/Thành phố</option>
                            <option value="hcm">TP Hồ Chí Minh</option>
                        </select>
                    </div>
                    <div class="form-group half-width">
                        <label for="district">Quận/Huyện (*)</label>
                        <select id="district" name="district" required>
                            <option value="">Chọn Quận/Huyện</option>
                            <option value="q12">Quận 12</option>
                            <option value="TD">TP Thủ Đức</option>
                        </select>
                    </div>
                    <div class="form-group half-width">
                        <label for="ward">Phường/Xã (*)</label>
                        <select id="ward" name="ward" required>
                            <option value="">Chọn Phường/Xã</option>
                            <option value="apd">An Phú Đông</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="address-detail">Địa chỉ chi tiết (*)</label>
                        <textarea name="detailAddress" id="address-detail" rows="3"
                                  placeholder="Ví dụ: 123/45 Đường Quang Trung, gần chợ ABC"
                                  required></textarea>
                    </div>
                </div>
                <button type="submit" id="submit-btn" name="action" value="add">Lưu Địa Chỉ</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const openBtn = document.getElementById("open-add-address-modal");
            const closeBtn = document.getElementById("close-change-address-modal");
            const modal = document.getElementById("address-modal");
            const textarea = document.getElementById("address-detail");

            openBtn.addEventListener("click", () => {
                document.getElementById("header-address").textContent = "Thêm địa chỉ mới";
                openModal();
            });

            closeBtn.addEventListener("click", closeModal);

            modal.addEventListener("click", (e) => {
                if (e.target === modal) {
                    closeModal();
                }
            });

            function openModal() {
                modal.style.display = "block";
                setTimeout(() => {
                    textarea.focus();
                }, 0);
            }

            function closeModal() {
                modal.style.display = "none";
            }
        });
    </script>
</form>