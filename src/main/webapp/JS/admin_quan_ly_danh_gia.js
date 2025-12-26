document.addEventListener("DOMContentLoaded", () => {
    /* ********************* QUẢN LÝ MENU & THÔNG BÁO ****************/
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

    /* ************* QUẢN LÝ REPLY MODAL (PHẢN HỒI) **************/
    const replyModal = document.getElementById("replyModal");
    const replyInput = document.getElementById("replyInput");
    const sendReplyButton = document.getElementById("sendReplyButton");

    let currentFeedbackData = {
        id: null,
        userId: null,
        customerName: ""
    };

    window.openReplyModal = function (feedbackId, userId, customerName, productName, rating, date) {
        if (!feedbackId) return;

        currentFeedbackData = { id: feedbackId, userId: userId, customerName: customerName };

        document.getElementById("modalCustomerName").innerText = customerName || "N/A";
        document.getElementById("modalProductName").innerText = productName || "N/A";
        document.getElementById("modalRatingStars").innerText = rating || 0;
        document.getElementById("modalReviewDate").innerText = date || "";

        const starContainer = document.getElementById("modalRatingStars");
        if (starContainer) {
            let stars = "";
            for (let i = 1; i <= rating; i++) {
                stars += `<i class="fas fa-star ${i <= rating ? 'text-warning' : ''}"></i>`;
            }
            starContainer.innerHTML = stars;
        }

        loadChatHistory(userId, customerName);

        replyModal.style.display = "block";
    };

    let currentFetchController = null;

    function loadChatHistory(userId, customerName) {
        if (currentFetchController) {
            currentFetchController.abort();
        }
        currentFetchController = new AbortController();
        const historyContainer = document.getElementById("modalReplyHistory");
        historyContainer.innerHTML = "<div class='text-center'>Đang tải lịch sử...</div>";

        fetch(`getFeedbackHistory?userId=${userId}`, { signal: currentFetchController.signal })
            .then(res => res.json())
            .then(data => {
                historyContainer.innerHTML = "";
                if (data.length === 0) {
                    historyContainer.innerHTML = "<p class='text-center'>Chưa có lịch sử phản hồi.</p>";
                    return;
                }
                data.forEach(item => {
                    const isCustomer = (item.response_id === 0);
                    const chatItem = document.createElement("div");
                    chatItem.className = `history-item ${isCustomer ? 'customer-review' : 'admin-reply'}`;

                    // Xử lý hiển thị thời gian đơn giản nếu item.created_at là object
                    const dateStr = typeof item.created_at === 'object' ?
                        `${item.created_at.date.day}/${item.created_at.date.month}/${item.created_at.date.year}` :
                        item.created_at;

                    chatItem.innerHTML = `
        <p class="history-meta"><strong>${isCustomer ? customerName : 'Bạn'}</strong> - ${dateStr}</p>
        <p class="history-text">${item.comment}</p>
    `;
                    historyContainer.appendChild(chatItem);
                });
                historyContainer.scrollTop = historyContainer.scrollHeight;
            })
            .catch(err => {
                if (err.name !== "AbortError") {
                    historyContainer.innerHTML = "<p class='text-danger'>Lỗi tải dữ liệu</p>";
                }
            });
    }

    if (sendReplyButton) {
        sendReplyButton.addEventListener("click", () => {
            const content = replyInput.value.trim();
            if (!content) {
                alert("Vui lòng nhập nội dung phản hồi.");
                return;
            }

            sendReplyButton.disabled = true;

            fetch("replyFeedback", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({
                    parentId: currentFeedbackData.id,
                    comment: content
                })
            })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        replyInput.value = "";
                        loadChatHistory(currentFeedbackData.userId, currentFeedbackData.customerName);
                    } else {
                        alert("Gửi phản hồi thất bại!");
                    }
                })
                .catch(err => {
                    console.error("Lỗi gửi phản hồi:", err);
                    alert("Đã có lỗi hệ thống xảy ra.");
                })
                .finally(() => {
                    sendReplyButton.disabled = false;
                });
        });
    }

    window.closeReplyModal = function () {
        replyModal.style.display = "none";
        if (replyInput) replyInput.value = "";
        // reset history
        const historyContainer = document.getElementById("modalReplyHistory");
        if (historyContainer) {
            historyContainer.innerHTML = "";
        }

        // reset state
        currentFeedbackData = {
            id: null,
            userId: null,
            customerName: ""
        };
    };

    /* *********** XỬ LÝ XÓA THỰC TẾ **************/
    window.deleteFeedback = function(feedbackId) {
        if (confirm("Bạn có chắc chắn muốn xóa đánh giá này? Dữ liệu phản hồi liên quan cũng sẽ bị xóa.")) {
            window.location.href = `quanlydanhgia?action=delete&id=${feedbackId}`;
        }
    };

    /* *********** SỬA EVENT DELEGATION **************/
    document.addEventListener("click", (event) => {
        const row = event.target.closest(".highlight-row");
        const isActionZone = event.target.closest("td:last-child");

        if (row && !isActionZone && replyModal.style.display !== "block") {
            const replyBtn = row.querySelector(".reply-btn");
            if (replyBtn) {
                replyBtn.click();
            }
        }

    });

    if (replyModal) {
        replyModal.addEventListener("click", (e) => {
            if (e.target === replyModal) {
                closeReplyModal();
            }
        });
    }


    /* *********** TÌM KIẾM & LỌC **************/
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