<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<div id="address-content" class="tab-content hidden">--%>
<div class="address-content header">
    <div class="header-left">
        <h1 class="txt big">ĐỊA CHỈ CỦA TÔI</h1>
    </div>
    <div class="header-right">
        <button class="add-address-button" id="open-add-address-modal">+ Thêm địa chỉ mới</button>
    </div>
</div>
<div class="address-content body">
    <div class="address-content content">
        <div class="address default">
            <p class="address-detail">
                56/12/34 Đường Võ Văn Kiệt, Phường 2, Quận 5, TP. Hồ Chí Minh, Việt Nam
            </p>
            <button id="setDefaultBtn1">Đặt mặc định</button>
            <span class="trash"><i class="fa-solid fa-trash"></i></span>
            <span class="edit open-change-address-modal"><i
                    class="fa-solid fa-pen-to-square"></i></span>
        </div>
        <div class="address">
            <p class="address-detail">
                108 Đường Nguyễn Văn Bá, Phường Trường Thọ, Thủ Đức, TP. Hồ Chí Minh, Việt Nam
            </p>
            <button id="setDefaultBtn2">Đặt mặc định</button>
            <span class="trash"><i class="fa-solid fa-trash"></i></span>
            <span class="edit open-change-address-modal"><i
                    class="fa-solid fa-pen-to-square"></i></span>
        </div>
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
                    <select id="province" required>
                        <option value="">Chọn Tỉnh/Thành phố</option>
                        <option value="hcm">TP Hồ Chí Minh</option>
                        <option value="hn">Hà Nội</option>
                    </select>
                </div>
                <div class="form-group half-width">
                    <label for="district">Quận/Huyện (*)</label>
                    <select id="district" required>
                        <option value="">Chọn Quận/Huyện</option>
                    </select>
                </div>
                <div class="form-group half-width">
                    <label for="ward">Phường/Xã (*)</label>
                    <select id="ward" required>
                        <option value="">Chọn Phường/Xã</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="address-detail">Địa chỉ chi tiết (*)</label>
                    <textarea id="address-detail" rows="3"
                              placeholder="Ví dụ: 123/45 Đường Quang Trung, gần chợ ABC"
                              required></textarea>
                </div>
            </div>
            <button type="submit" id="submit-btn">Lưu Địa Chỉ</button>
        </div>
    </div>
</div>