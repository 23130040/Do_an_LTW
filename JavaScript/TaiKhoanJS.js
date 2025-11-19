document.addEventListener("DOMContentLoaded", () => {

    //thay đổi giao diện khi nhấn vào các link trong sidebar
    changeTab();

    //Lưu thông tin
    const saveInfoBtn = document.getElementById("saveInfoBtn");
    saveInfoBtn.addEventListener("click", () => {
        saveInfo("Lưu thông tin thành công");
    });

    //Lưu mật khẩu
    const savePasswordBtn = document.getElementById("savePasswordBtn");
    savePasswordBtn.addEventListener("click", () => {
       saveInfo("Đổi mật khẩu thành công! Vui lòng đăng nhập lại!");
    });
    const closeSaveModal = document.getElementById("closeConfirmSavemodal");
    closeSaveModal.addEventListener("click", () => {
        closeModal("confirmSave");
    });
});

function changeTab(targetId) {
    //1. Lấy tất cả các link trong sidebar
    const sidebarLinks = document.querySelectorAll('#sidebar .sidebar.menu a');
    //2. lây tất cả các nội dung tab
    const tabContents = document.querySelectorAll('.main-content .tab-content');
    function switchTab(targetId) {
        // A. Ẩn tất cả các nội dung tab
        tabContents.forEach(content => {
            content.classList.remove('active');
            content.classList.add('hidden');
        });

        const targetContent = document.querySelector(targetId);
        if (targetContent) {
            targetContent.classList.add('active');
            targetContent.classList.remove('hidden');
        }
        sidebarLinks.forEach(link => {
            // Xóa lớp 'active-link' khỏi tất cả
            link.classList.remove('active-link');
        });
        // Thêm lớp 'active-link' vào link hiện tại
        document.querySelector(`#sidebar .sidebar.menu a[href="${targetId}"]`).classList.add('active-link');
    }
    // 3. Thiết lập sự kiện click cho các liên kết
    sidebarLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            // Ngăn chặn hành vi mặc định của thẻ <a> (chuyển hướng/nhảy trang)
            event.preventDefault();

            const targetId = this.getAttribute('href');

            // Gọi hàm chuyển đổi tab
            switchTab(targetId);
        });
    });

    const initialTarget = sidebarLinks[0].getAttribute('href');
    switchTab(initialTarget);
}

function saveInfo(message){
    const confirmSavemodal = document.getElementById('confirmSave');
    confirmSavemodal.style.display = 'block';

    const messageConfirm = document.getElementById('messageConfirm');
    messageConfirm.innerText = message;
}

function closeModal(id){
    document.getElementById(id).style.display = "none";
}
