document.addEventListener("DOMContentLoaded", () => {
    //1. Lấy tất cả các link trong sidebar
    const sidebarLinks = document.querySelectorAll('#sidebar .sidebar.menu a');
    //2. lây tất cả các nội dung tab
    const tabContents = document.querySelectorAll('.main-content .tab-content');
    function switchTab(targetId) {
        // A. Ẩn tất cả các nội dung tab
        tabContents.forEach(content => {
            content.classList.remove('active'); // Xóa lớp 'active'
            content.classList.add('hidden');    // Thêm lớp 'hidden' (nếu bạn định nghĩa trong CSS)
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

            // Lấy href (ví dụ: '#profile-content') để xác định tab cần hiển thị
            const targetId = this.getAttribute('href');

            // Gọi hàm chuyển đổi tab
            switchTab(targetId);
        });
    });

    // 4. Thiết lập tab mặc định khi tải trang (ví dụ: tab đầu tiên)
    // Tùy chọn: Gọi switchTab cho tab đầu tiên nếu nó chưa active
    const initialTarget = sidebarLinks[0].getAttribute('href');
    switchTab(initialTarget);
});