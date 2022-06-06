new Swiper(`#comment-slider-${BLOCK.ID}`, {
    slidesPerView: 1,
    spaceBetween: T.isMobile() ? 8 : 15,
    pagination: {
        el: `#swiper-pagination-${BLOCK.ID}`,
        clickable: true
    },
});