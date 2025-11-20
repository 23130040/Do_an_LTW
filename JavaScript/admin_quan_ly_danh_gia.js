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

// Hàm MỞ Modal Trả lời
function openReplyModal() {
    const modal = document.getElementById('replyModal');
    if (modal) {
        modal.style.display = 'block';
    }
}

// Hàm ĐÓNG Modal Trả lời
function closeReplyModal() {
    const modal = document.getElementById('replyModal');
    if (modal) {
        modal.style.display = 'none';
        // Tùy chọn: Xóa nội dung nhập cũ khi đóng
        const replyInput = document.getElementById('replyInput');
        if (replyInput) {
            replyInput.value = '';
        }
    }
}

const reviewRows = document.querySelectorAll('.highlight-row');

reviewRows.forEach(row => {
    // Gán sự kiện click cho TẤT CẢ các hàng
    row.addEventListener('click', function(event) {
        const isActionButton = event.target.closest('td:last-child');
        if (!isActionButton) {
            openReplyModal();
        }
    });
});

const replyButtons = document.querySelectorAll('.reply-btn');
replyButtons.forEach(button => {
    button.addEventListener('click', function(event) {
        event.stopPropagation();
        openReplyModal();
    });
});


const sendButton = document.getElementById('sendReplyButton');
if (sendButton) {
    sendButton.addEventListener('click', function() {
        const replyText = document.getElementById('replyInput').value.trim();
        if (replyText) {
            alert('Đã gửi phản hồi mẫu: ' + replyText);
            closeReplyModal();
        } else {
            alert('Vui lòng nhập nội dung phản hồi.');
        }
    });
}

window.onclick = function(event) {
    const userDropdown = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");
    const replyModal = document.getElementById('replyModal');

    // Logic đóng User Dropdown
    if (
        !event.target.matches('.user-logo') &&
        userDropdown && userDropdown.classList.contains('show') &&
        !event.target.closest('.user-dropdown')
    ) {
        userDropdown.classList.remove('show');
    }

    // Logic đóng Notification Panel
    if (
        notificationPanel &&
        notificationPanel.classList.contains('show-panel') &&
        !event.target.matches('.notification-icon') &&
        !event.target.closest('#notification-panel')
    ) {
        notificationPanel.classList.remove('show-panel');
    }

    // Logic đóng Reply Modal
    if (event.target === replyModal) {
        closeReplyModal();
    }
}