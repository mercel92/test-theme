const runSlider = (el) => {
    new Swiper(el, {
        slidesPerView: 1,
        spaceBetween: T.isMobile() ? 15 : 30,
        navigation: {
            nextEl: `#swiper-next-${BLOCK.ID}`,
            prevEl: `#swiper-prev-${BLOCK.ID}`,
        },
        breakpoints: {
            576: {
                slidesPerView: 2
            },
            768: {
                slidesPerView: 3
            }
        }
    });
}
runSlider(`.blog-recent-post${BLOCK.ID} .swiper-container`);