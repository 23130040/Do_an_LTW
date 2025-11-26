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
    const openSearchBar = document.getElementById("open-searchBar");
    openSearchBar.addEventListener("click", showSearchBar);
    const closeSearchBarBtn = document.getElementById("close-searchBar");
    closeSearchBarBtn.addEventListener("click", closeSearchBar);

    //xác nhận đặt hàng
    const confirmOrder = document.getElementById("confirmOrder");
    confirmOrder.addEventListener("click", () => {
        document.getElementById("redirect-modal").style.display = "block";
    });
    const returnToHome = document.getElementById("return-to-home-btn");
    returnToHome.addEventListener("click", () => {
        window.location.href = "../HTML/trang_chu_da_login.html";
    });
    const viewOrders = document.getElementById("view-orders-btn");
    viewOrders.addEventListener("click", () => {
        window.location.href = "../HTML/donhang.html";
    });

    const opendeliveryMessageBtn = document.getElementById("opendeliverymessage");
    const  deliveryMessage = document.getElementById("delivery-message");
    opendeliveryMessageBtn.addEventListener("click", () => {
        deliveryMessage.style.display = "block";
    });

    /**Xử lý việc ẩn thông tin vận chuyển*/
    const closedeliveryMessageBtn = document.getElementById("close-message-modal");
    closedeliveryMessageBtn.addEventListener("click", () => {
        deliveryMessage.style.display = "none";
    });

    window.addEventListener('click', (e) => {
        if (e.target === deliveryMessage) deliveryMessage.style.display = "none";
    });
});