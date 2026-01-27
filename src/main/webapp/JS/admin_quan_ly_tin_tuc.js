// Hàm User Menu
function toggleUserMenu() {
    document.getElementById("userMenuContent").classList.toggle("show");
}
// Hàm cho Notification Menu
function toggleNotificationMenu() {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    // 1. Đóng User Menu nếu nó đang mở
    if (userDropdown) {
        userDropdown.classList.remove("show");
    }

    // 2. Bật/Tắt Notification Panel
    if (notificationPanel) {
        notificationPanel.classList.toggle("show-panel");
    }
}


// Xử lý đóng cả hai menu khi người dùng click ra ngoài
window.onclick = function(event) {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");
    const notificationIcon = document.querySelector('.notification-icon');

    if (
        !event.target.matches('.user-logo') &&
        userDropdown && userDropdown.classList.contains('show') &&
        !event.target.closest('.user-dropdown')
    ) {
        userDropdown.classList.remove('show');
    }

    if (
        notificationPanel &&
        notificationPanel.classList.contains('show-panel') &&
        !event.target.matches('.notification-icon') &&
        !event.target.closest('#notification-panel')
    ) {
        notificationPanel.classList.remove('show-panel');
    }
}

// Hàm mở modal chung
function openModal(modalId) {
    document.getElementById(modalId).style.display = 'block';
}

// Hàm đóng modal chung
function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

function editNews(id) {
    console.log("Đang sửa tin tức ID:", id);
    document.getElementById('modal-title-article').textContent = 'Chỉnh sửa';

    fetch(`quan-ly-tin-tuc?action=get&id=${id}`)
        .then(res => {
            if (!res.ok) throw new Error("Lỗi mạng");
            return res.json();
        })
        .then(data => {
            document.getElementById('news-id').value = data.id;
            document.getElementById('news-title').value = data.title;
            document.getElementById('news-author').value = data.author;
            document.getElementById('news-content').value = data.content;
            document.getElementById('news-status').value = data.status;

            // Gọi hàm mở modal
            openModal('article-modal');
        })
        .catch(err => {
            console.error("Lỗi lấy dữ liệu:", err);
            alert("Không thể tải dữ liệu bài viết!");
        });
}

function deleteAndKeepPage(id, currentPage) {
    if(confirm('Bạn có chắc chắn muốn xóa bài viết này?')) {
        window.location.href = `quan-ly-tin-tuc?action=delete&id=${id}&page=${currentPage}`;
    }
}

function openAddArticleModal() {
    document.getElementById('modal-title-article').textContent = 'Tạo';
    document.getElementById('news-id').value = '';
    document.querySelector('.article-form').reset();
    openModal('article-modal');
}