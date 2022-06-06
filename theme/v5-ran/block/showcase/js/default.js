const runSlider = (el) => {
    new Swiper(el, {
        slidesPerView: SETTING.COL.ALL,
        spaceBetween: T.isMobile() ? 15 : 30,
        navigation: {
            nextEl: `#swiper-next-${BLOCK.ID}`,
            prevEl: `#swiper-prev-${BLOCK.ID}`,
        },
        breakpoints: {
            576: {
                slidesPerView: SETTING.COL.SM,
            },
            768: {
                slidesPerView: SETTING.COL.MD,
            },
            992: {
                slidesPerView: SETTING.COL.LG,
            },
            1170: {
                slidesPerView: SETTING.COL.XL,
            },
        },
    });
}

T(`.compare-selected-btn-${BLOCK.ID}${BLOCK.PARENT_ID}`).on(mouseHoverEvents[0], el => {
    const menu = el.target.parentNode.querySelector('.compare-list');
    const active = T('.add-to-compare-btn.active');
    T(menu).html('');
    if (active.length <= 0) return;
    Array.from(active).forEach(compare => {
        const src = compare.closest('.product-item').querySelector('.image-inner img').src;
        const item = document.createElement('div');
        item.innerHTML = `<i class="compare-remove ti-close" data-id="${compare.dataset.id}"></i>
                         <span class="image-wrapper bg-white"><span class="image-inner"><img src="${src}"></span></span>`;
        menu.append(item);
        item.querySelector('.compare-remove').addEventListener('click', el => {
            T(`.add-to-compare-btn.active[data-id="${el.target.dataset.id}"]`).trigger('click');
            el.target.parentNode.remove();
        });
    });
});

window[`tab${BLOCK.ID}${BLOCK.PARENT_ID}`] = (tab, tabContent) => {
    runSlider(tabContent.querySelector('.swiper-container'));
    initComponents();
}

runSlider(`#producttab${BLOCK.ID}${BLOCK.PARENT_ID}1 > .swiper-container`);