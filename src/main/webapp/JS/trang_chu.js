
// Cuộn ngang trang khi ấn mũi tên trái phải
function scrollToLeft(button) {
    const carousel = button.closest('.product-carousel');
    const list = carousel.querySelector('.product-list');
    list.scrollBy({left: -300, behavior: 'smooth'});
}

function scrollToRight(button) {
    const carousel = button.closest('.product-carousel');
    const list = carousel.querySelector('.product-list');
    list.scrollBy({left: 300, behavior: 'smooth'});
}