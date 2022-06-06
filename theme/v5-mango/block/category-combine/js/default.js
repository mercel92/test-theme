const runSlider = (el) => {
    new Swiper(el, {
        slidesPerView: 2,
        spaceBetween: T.isMobile() ? 15 : 30,
        navigation: {},
        pagination: {
            el: `#swiper-pagination-${BLOCK.ID}`,
            clickable: true
        },
        breakpoints: {
            576: {
                slidesPerView: 2
            },
            768: {
                slidesPerView: 4,
                pagination: false,
                navigation: {
                    nextEl: `#swiper-next-${BLOCK.ID}`,
                    prevEl: `#swiper-prev-${BLOCK.ID}`,
                },
            }
        }
    });
}

runSlider(`#combin-list-${BLOCK.ID} > .swiper-container`);