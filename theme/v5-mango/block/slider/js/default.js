const thumbs = new Swiper(`#slider-thumb-${BLOCK.ID}`, {
    slidesPerView: 6,
    spaceBetween: 8,
    watchSlidesProgress: true,
    breakpoints: {
        576: {
            slidesPerView: 8,
            spaceBetween: SETTING.MARGIN.SM,
        },
        768: {
            slidesPerView: 10,
            spaceBetween: SETTING.MARGIN.MD,
        },
        992: {
            slidesPerView: 10,
            spaceBetween: SETTING.MARGIN.LG,
        },
        1170: {
            slidesPerView: 12,
            spaceBetween: SETTING.MARGIN.XL,
        },
    },
});

const slider = new Swiper(`#slider-block-${BLOCK.ID}`, {
    slidesPerView: SETTING.PERVIEW.ALL,
    spaceBetween: SETTING.MARGIN.ALL,
    breakpoints: {
        576: {
            slidesPerView: SETTING.PERVIEW.SM,
            spaceBetween: SETTING.MARGIN.SM,
        },
        768: {
            slidesPerView: SETTING.PERVIEW.MD,
            spaceBetween: SETTING.MARGIN.MD,
        },
        992: {
            slidesPerView: SETTING.PERVIEW.LG,
            spaceBetween: SETTING.MARGIN.LG,
        },
        1170: {
            slidesPerView: SETTING.PERVIEW.XL,
            spaceBetween: SETTING.MARGIN.XL,
        },
    },
    effect: SETTING.EFFECT || 'slide',   
    autoplay: {
        delay:  SETTING.DELAY + '000',
    },
    navigation: {
        nextEl: SETTING.DISPLAY_NAVIGATION == 1 ? `#swiper-next-${BLOCK.ID}` : '',
        prevEl: SETTING.DISPLAY_NAVIGATION == 1 ? `#swiper-prev-${BLOCK.ID}` : ''
    },
    pagination: {
        el: SETTING.PAGINATION_TYPE ? `#swiper-pagination-${BLOCK.ID}` : '',
        type: SETTING.PAGINATION_TYPE,
        clickable: true,
        renderCustom: function (swiper, current, total) {
            if (SETTING.PAGINATION_TYPE != 'custom') return;
            let customs = "";
            for(let i=1; i<total + 1; i++) {
                if(i == current) {
                    customs += '<span class="swiper-pagination-customs swiper-pagination-customs-active">'+ i +'</span>';
                } else {
                    customs += '<span class="swiper-pagination-customs">'+ i +'</span>';
                }
            }
            return customs;
        },
    },
    lazy: {
        loadPrevNext: true
    },
    thumbs: {
        swiper: SETTING.DISPLAY_THUMBNAIL == 1 ? thumbs : ''
    },
});

if (SETTING.DELAY == '' || SETTING.DELAY == 0) {
    slider.autoplay.stop();
}