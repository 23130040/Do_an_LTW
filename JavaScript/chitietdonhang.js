function showSearchBar(){
    const searchBarContainer = document.getElementById("searchBar");
    searchBarContainer.classList.add("active");
    const inputSearchbar = document.getElementById("input-searchBar");
    inputSearchbar.classList.add("active");
    const closeMenuBar = document.getElementById("close-searchBar");
    closeMenuBar.classList.add("active");
}
function closeSearchBar(){
    const searchBarContainer = document.getElementById("searchBar");
    searchBarContainer.classList.remove("active");
    const inputSearchbar = document.getElementById("input-searchBar");
    inputSearchbar.classList.remove("active");
    const closeMenuBar = document.getElementById("close-searchBar");
    closeMenuBar.classList.remove("active");
}
document.addEventListener("DOMContentLoaded", () => {
    /**Xử lý sự kiện cho thanh tìm kiếm*/
    const openSearchBar = document.getElementById("open-searchBar");
    openSearchBar.addEventListener("click", showSearchBar);
    const closeSearchBarBtn = document.getElementById("close-searchBar");
    closeSearchBarBtn.addEventListener("click", closeSearchBar);

    const openDeliveryMessage = document.getElementById("open-delivery-message");
    openDeliveryMessage.addEventListener("click", () => {
       document.getElementById("delivery-message").style.display = "block";
    });
    const closeDeliveryMessageBtn = document.getElementById("close-message-modal");
    closeDeliveryMessageBtn.addEventListener("click", () => {
        document.getElementById("delivery-message").style.display = "none";
    });

    /**Xử lý hủy đơn hàng*/
    /*Mở modal xác nhận hủy đơn*/
    const openCancleModalBtn = document.getElementById("cancle-order-btn");
    openCancleModalBtn.addEventListener("click", () => {
        document.getElementById("confirm-cancle-order-modal").style.display = "block";
    });
    /*Đóng modal xác nhận hủy đơn*/
    const closeCancleModalBtn = document.getElementById("close-confirm-cancle-order-modal");
    closeCancleModalBtn.addEventListener("click", () => {
        document.getElementById("confirm-cancle-order-modal").style.display = "none";
    });
    const cancleBtn = document.getElementById("cancle-btn");
    cancleBtn.addEventListener("click", () => {
        document.getElementById("confirm-cancle-order-modal").style.display = "none";
    });
    /*Sau khi xác nhận hủy đơn thì mở modal xác nhận hủy đơn thành công bằng btn 'xác nhận'*/
    const confirmBtn = document.getElementById("confirm-btn");
    confirmBtn.addEventListener("click", () => {
        document.getElementById("redirect-modal").style.display = "block";
    });
    /*chuyển hướng đến trang chủ nếu chọn vào button quay về trang chủ*/
    const returnHomebtn = document.getElementById("return-to-home-btn");
    returnHomebtn.addEventListener("click", () => {
        window.location.href = "../HTML/trang_chu_da_login.html";
    });
    /*chuyển hướng đến trang đơn hàng nếu chọn button xem đơn hàng của tôi*/
    const viewOrderBtn = document.getElementById("view-orders-btn");
    viewOrderBtn.addEventListener("click", () => {
        window.location.href = "../HTML/donhang.html";
    });
    window.addEventListener("click", (e) =>{
        if (e.target === document.getElementById("delivery-message")){
            document.getElementById("delivery-message").style.display = "none";
        }
        if (e.target === document.getElementById("confirm-cancle-order-modal")){
            document.getElementById("confirm-cancle-order").style.display = "none";
        }
    });
});