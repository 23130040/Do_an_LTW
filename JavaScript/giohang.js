document.addEventListener("DOMContentLoaded", () => {
    /**Xử lý tăng giảm số lượng*/
    const decreaseBtn1 = document.getElementById("decrease1");
    decreaseBtn1.addEventListener("click", () => {
        decrease("SP001");
        updateTotal("price1","SP001","sum1");
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    }) ;

    const decreaseBtn2 = document.getElementById("decrease2");
    decreaseBtn2.addEventListener("click", () => {
        decrease("SP002");
        updateTotal("price2","SP002","sum2");
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    });

    const decreaseBtn3 = document.getElementById("decrease3");
    decreaseBtn3.addEventListener("click", () => {
        decrease("SP003");
        updateTotal("price3","SP003","sum3");
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    });

    const increaseBtn1 = document.getElementById("increase1");
    increaseBtn1.addEventListener("click", () => {
        increase("SP001");
        updateTotal("price1","SP001","sum1");
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    });

    const increaseBtn2 = document.getElementById("increase2");
    increaseBtn2.addEventListener("click", () => {
        increase("SP002");
        updateTotal("price2","SP002","sum2");
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    });

    const increaseBtn3 = document.getElementById("increase3");
    increaseBtn3.addEventListener("click", () => {
        increase("SP003");
        updateTotal("price3","SP003","sum3");
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    });

    /**Xử lý tính tổng tiền của từng sản phẩm*/
    const sum1 = document.getElementById("sum1");
    sum1.innerHTML = total("price1","SP001");
    const sum2 = document.getElementById("sum2");
    sum2.innerHTML = total("price2","SP002");
    const sum3 = document.getElementById("sum3");
    sum3.innerHTML = total("price3","SP003");

    /**Xử lý tính tổng tiền hàng*/
    const totalOrders = document.getElementById("total-order");
    totalOrders.innerHTML = totalOrder();

    /**Xử lý việc tính thành tiền*/
    const subTotal = document.getElementById("subtotal");
    subTotal.innerHTML = calculateSubTotal();

    /**Xử lý việc hiện thông tin vân chuyện*/
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

    /**Xử lý việc xóa sản phẩm*/
    const product1 = document.getElementById("product1");
    const product2 = document.getElementById("product2");
    const product3 = document.getElementById("product3");

    const deleteProductBtn1 = document.getElementById("trash1");
    deleteProductBtn1.addEventListener("click", () => {
        product1.style.display = "none";
        document.getElementById("sum1").innerText = '0';
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    });
    const deleteProductBtn2 = document.getElementById("trash2");
    deleteProductBtn2.addEventListener("click", () => {
        product2.style.display = "none";
        document.getElementById("sum2").innerText = '0';
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    });
    const deleteProductBtn3 = document.getElementById("trash3");
    deleteProductBtn3.addEventListener("click", () => {
        product3.style.display = "none";
        document.getElementById("sum3").innerText = '0';
        updateTotalOrder();
        updateCalculateSubTotalOrder();
    });


    window.addEventListener('click', (e) => {
        if (e.target === deliveryMessage) deliveryMessage.style.display = "none";
    });

});

function decrease(id){
    const quantityInput = document.getElementById(id);
    let quantity = Number(quantityInput.value);

    if (quantity > 0.1) {
        quantity -= 0.1;
        quantity = Number(quantity.toFixed(1));
    }
    quantityInput.value = quantity;
}

function increase(id){
    const quantityInput = document.getElementById(id);
    let quantity = Number(quantityInput.value);

    quantity += 0.1;
    quantity = Number(quantity.toFixed(1));
    quantityInput.value = quantity;
}

function total(priceId, amountId){
    const price = parseFloat(document.getElementById(priceId).innerText.replaceAll(",",""));
    const amount = Number(document.getElementById(amountId).value);
    return (price * amount).toLocaleString("en-US");
}

function updateTotal(priceId, amountId, sumId){
    const sum = document.getElementById(sumId);
    sum.innerHTML = total(priceId, amountId).toLocaleString("en-US");
}

function totalOrder(){
    let total = 0;
    const cells = document.querySelectorAll("td.sum span.total");
    cells.forEach(cell => {
        let value = cell.innerText.replaceAll(",","");
        total += parseFloat(value);
    });
    return total.toLocaleString("en-US");
}

function updateTotalOrder(){
    const total = totalOrder();
    document.getElementById("total-order").innerText = total;
}

function calculateSubTotal(){
    const totalOrderValue = parseFloat(document.getElementById("total-order").innerText.replaceAll(",", ""));
    const discountValue = parseFloat(document.getElementById("discount").innerText.replaceAll(",", ""));
    const deliveryFeeValue = parseFloat(document.getElementById("delivery").innerText.replaceAll(",", ""));
    const deliveryDiscountValue = parseFloat(document.getElementById("delivery-discount").innerText.replaceAll(",", ""));

    let subTotal = totalOrderValue - discountValue + deliveryFeeValue - deliveryDiscountValue;

    return subTotal.toLocaleString("en-US");
}

function updateCalculateSubTotalOrder(){
    const total = calculateSubTotal();
    document.getElementById("subtotal").innerText = total;
}
