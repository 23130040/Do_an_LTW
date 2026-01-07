<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<div id="address-content" class="tab-content hidden">--%>
<div class="address-content header">
    <div class="header-left">
        <h1 class="txt big">ĐỊA CHỈ CỦA TÔI</h1>
    </div>
    <div class="header-right">
        <button type="button" class="add-address-button" id="open-add-address-modal">+ Thêm địa chỉ mới</button>
    </div>
</div>
<div class="address-content body">
    <div class="address-content content">
        <c:choose>
            <c:when test="${not empty addresses}">
                <c:forEach var="addr" items="${addresses}">
                    <form action="${pageContext.request.contextPath}/tai-khoan" method="post">
                        <div class="address ${addr.defaultAddress ? 'default' : ''}">
                            <p class="address-detail">
                                    ${addr.address}
                            </p>
                            <c:if test="${!addr.defaultAddress}">
                                <input type="hidden" name="addressId" value="${addr.id}"/>

                                <button class="set-default-btn"
                                        type="submit"
                                        name="action"
                                        value="setDefault">
                                    Đặt mặc định
                                </button>

                                <button type="submit" class="trash" name="action" value="delete"><i
                                        class="fa-solid fa-trash"></i>
                                </button>
                            </c:if>
                            <c:if test="${addr.defaultAddress}">
                                <button class="set-default-btn default-btn disabled" disabled>Mặc định</button>
                                <button class="trash default-btn disabled" disabled><i
                                        class="fa-solid fa-trash"></i>
                                </button>
                            </c:if>
                            <button class="edit open-change-address-modal" aria-label="Sửa địa chỉ"
                                    data-id="${addr.id}"><i
                                    class="fa-solid fa-pen-to-square"></i>
                            </button>
                        </div>
                    </form>
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
        <form class="address-form" action="${pageContext.request.contextPath}/tai-khoan" method="post">
            <h2 id="header-address"></h2>
            <div class="form-row">
                <div class="form-group">
                    <label for="address-detail">Địa chỉ mới (*)</label>
                    <textarea name="address" id="address-detail" rows="3"
                              placeholder="Ví dụ: 123/45 Đường Quang Trung, gần chợ A, phường B, huyện C, tỉnh D..."
                              required></textarea>
                </div>
            </div>
            <button type="submit" id="submit-btn" name="action" value="add">Lưu Địa Chỉ</button>
        </form>
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