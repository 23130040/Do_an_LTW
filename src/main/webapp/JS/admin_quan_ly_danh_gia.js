document.addEventListener("DOMContentLoaded", () => {
    /* ********************* MENU & NOTIFICATION ****************/
    const userMenu = document.getElementById("userMenuContent");
    const notificationPanel = document.getElementById("notification-panel");

    window.toggleUserMenu = function () {
        userMenu.classList.toggle("show");
        notificationPanel.classList.remove("show-panel");
    };

    window.toggleNotificationMenu = function () {
        userMenu.classList.remove("show");
        notificationPanel.classList.toggle("show-panel");
    };

    document.addEventListener("click", (event) => {
        if (!event.target.closest(".user-dropdown") && !event.target.matches(".user-logo")) {
            userMenu.classList.remove("show");
        }
        if (!event.target.closest("#notification-panel") && !event.target.matches(".notification-icon")) {
            notificationPanel.classList.remove("show-panel");
        }
    });

    /* ************* REPLY MODAL (PHẢN HỒI) **************/
    const replyModal = document.getElementById("replyModal");
    const replyInput = document.getElementById("replyInput");

    window.openReplyModal = function (feedbackId = null) {
        if (feedbackId) {
            console.log("Đang mở phản hồi cho ID:", feedbackId);
        }

        replyModal.style.display = "block";
    };

    window.closeReplyModal = function () {
        replyModal.style.display = "none";
        if (replyInput) replyInput.value = "";
    };

    const sendReplyButton = document.getElementById("sendReplyButton");
    if (sendReplyButton) {
        sendReplyButton.addEventListener("click", () => {
            const content = replyInput.value.trim();
            if (content) {
                alert("Đã gửi phản hồi: " + content);
                closeReplyModal();
            } else {
                alert("Vui lòng nhập nội dung phản hồi.");
            }
        });
    }

    /* *********** EVENT DELEGATION CHO BẢNG ĐÁNH GIÁ **************/
    document.addEventListener("click", (event) => {
        const replyBtn = event.target.closest(".reply-btn");
        if (replyBtn) {
            event.stopPropagation();
            openReplyModal();
            return;
        }

        const deleteBtn = event.target.closest(".delete-btn");
        if (deleteBtn) {
            event.stopPropagation();
            const feedbackId = "nào đó";
            if (confirm("Bạn có chắc chắn muốn xóa đánh giá này?")) {
                alert("Đã xóa ID: " + feedbackId);
            }
            return;
        }

        const row = event.target.closest(".highlight-row");
        if (row && !event.target.closest("td:last-child")) {
            openReplyModal();
        }

        if (event.target === replyModal) {
            closeReplyModal();
        }

        if (event.target.closest(".close-btn")) {
            closeReplyModal();
        }
    });

    /* *********** SEARCH & FILTER (LỌC ĐÁNH GIÁ) **************/
    const searchInput = document.getElementById('searchInput');
    const rateFilter = document.getElementById('rateFilter');
    const typeFilter = document.getElementById('typeFilter');

    function applyFilterAndSearch() {
        const keyword = searchInput.value.trim();
        const rate = rateFilter.value;
        const type = typeFilter.value;

        const params = new URLSearchParams();
        if (keyword) params.append('search', keyword);
        if (rate) params.append('rating', rate);
        if (type) params.append('type', type);

        window.location.href = 'quanlydanhgia?' + params.toString();
    }

    if (searchInput) {
        searchInput.addEventListener('keydown', (event) => {
            if (event.key === 'Enter') {
                event.preventDefault();
                applyFilterAndSearch();
            }
        });
    }

    if (rateFilter) rateFilter.addEventListener('change', applyFilterAndSearch);
    if (typeFilter) typeFilter.addEventListener('change', applyFilterAndSearch);
});