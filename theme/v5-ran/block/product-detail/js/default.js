const thumbWrapper = T(`.product-thumb-slider-wrapper`);
if (thumbWrapper.length > 0) {
    thumbWrapper[0].classList.remove('d-none');
    var thumb = new Swiper(`#product-thumb-slider-${BLOCK.ID}`, {
        spaceBetween: T.isMobile() ? 15 : 30,
        slidesPerView: 4,
        watchSlidesVisibility: true,
        watchSlidesProgress: true,
        navigation: {
            nextEl: `#swiper-thumb-next-${BLOCK.ID}`,
            prevEl: `#swiper-thumb-prev-${BLOCK.ID}`,
        },
    });
}

var slide = new Swiper(`#product-detail-slider-${BLOCK.ID}`, {
    navigation: {
        nextEl: `#swiper-next-${BLOCK.ID}`,
        prevEl: `#swiper-prev-${BLOCK.ID}`,
    },
    thumbs: {
        swiper: thumbWrapper.length > 0 ? thumb : '',
    },
    observer : true,
    observeSlideChildren: true,
    observeParents: true,
});

const gallery = T(`#gallery-${BLOCK.ID}`);
const productGallery = (filter = null) => {
    lightGallery(gallery[0], {
        actualSize : false,
        download : false,
        thumbnail: true,
        animateThumb: false,
        showThumbByDefault: true,
        thumbWidth : 60,
        selector: filter == null || T(filter).length == 0 ? '' : filter
    });
};

if (gallery.length > 0) productGallery();

const subOne = T('#product-right .sub-one')[0];
if (subOne) {
    const selected = subOne.querySelector('.selected');
    if (selected) {
        slideChange(selected);
        filterGallery(selected);
    }

    const subEvents = subOne.querySelectorAll('a, select');
    Array.from(subEvents).forEach(element => {
        const event = element.nodeName == 'SELECT' ? 'change' : 'click';
        T(element).on(event, () => {
            const sub = element.nodeName == 'SELECT' ? element.options[element.options.selectedIndex] : element;
            slideChange(sub);
            filterGallery(sub);
         });
    });

    function slideToggle(slide) {
        slide.forEach(() => {
            T(slide).show();
            T(slide).addClass('swiper-slide');
        });
    }

    function slideChange(sub) {
        const wrapItem = T(`#product-detail-images-wrapper-${BLOCK.ID}`)[0],
              slideItem = wrapItem.querySelectorAll('.slide-item');
        T(slideItem).hide();
        T(slideItem).removeClass('swiper-slide', 'swiper-slide-active', 'swiper-slide-next');

        const defaultSlides = wrapItem.querySelectorAll('.slide-item[data-id="0"]');
        const activeSlides = wrapItem.querySelectorAll(`.slide-item[data-id="${sub.dataset.id}"]`);

        if (activeSlides.length > 0) { 
            slideToggle(activeSlides); 
        } else if (defaultSlides.length > 0) { 
            slideToggle(defaultSlides); 
        } else { 
            slideToggle(slideItem); 
        }

        slide.slideTo(0, false,false);
        if (thumbWrapper.length > 0) thumb.update();
        slide.update();
    }

    function filterGallery(sub) {
        if (gallery.length > 0) {
            const filter = `.slide-item[data-id="${sub.dataset.id}"]`;
            window.lgData[gallery[0].getAttribute('lg-uid')].prevScrollTop = window.pageYOffset;
            window.lgData[gallery[0].getAttribute("lg-uid")].destroy(true);
            productGallery(filter);
        }
    }
}