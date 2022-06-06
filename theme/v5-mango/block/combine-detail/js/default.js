const slidelength = T(`.combine-thumb-slider-wrapper`);
if ( slidelength.length > 0) {
    slidelength[0].classList.remove('d-none');
    var thumbSlider = new Swiper(`#combine-thumb-slider-${BLOCK.ID}`, {
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

var imageSlider = new Swiper(`#combine-detail-slider-${BLOCK.ID}`, {
    navigation: {
        nextEl: `#swiper-next-${BLOCK.ID}`,
        prevEl: `#swiper-prev-${BLOCK.ID}`,
    },
    pagination: {
        el: `#swiper-pagination-${BLOCK.ID}`,
        clickable: true
    },
    thumbs: {
        swiper: slidelength.length > 0 ? thumbSlider : '',
    },
});

lightGallery(document.getElementById(`gallery-${BLOCK.ID}`), {
    actualSize : false,
    download : false,
    thumbnail: true,
    animateThumb: false,
    showThumbByDefault: true,
    thumbWidth : 80,
});

Array.from(T('.combine-product-add')).forEach(el => {
    T(el).on('click', () => {
        const pid = el.dataset.id,
              sub = T(`#subPro${pid}${BLOCK.ID}`)[0],
              qty = T(`#qtyCount${pid}${BLOCK.ID}`)[0];
        if (sub.dataset.variant == 1 && sub.value == 0) {
            T.notify({
                text: "{#choose_sub_product#}",
                className: 'danger',
                duration: 3200,
            });
            return;
        }
        addToCart(pid, sub.value, qty.value);
    });
});

T(`#combine-add-all-${BLOCK.ID}`).on('click', () => {
    const inputs = T('input.combine-select-input:checked');
    if(inputs.length < 1) {
        T.notify({
            text: '{#no_selected_product#}',
            className: 'danger',
            duration: 1800,
        });
        return;
    }
    const pids = [], variants = [], counts = [];
    let danger = 0;
    Array.from(inputs).forEach(input => {
        const id = input.dataset.target,
              sub = T(`#subPro${id}${BLOCK.ID}`)[0],
              qty = T(`#qtyCount${id}${BLOCK.ID}`)[0],
              pidName = input.dataset.name;
        if (sub.dataset.variant == 1 && sub.value == 0) {
            T.notify({
                text: `<a href="#combine-product-item-${id}${BLOCK.ID}">${pidName}</a> {#choose_sub_product#}`,
                className: 'danger',
                stopOnFocus : true,
                duration: 3200,
            });
            danger = 1;
            return;
        }
        pids.push(id);
        variants.push(sub.value);
        counts.push(qty.value);
    });
    if (danger == 1) return;
    multiCart = true;
    addToCart(pids, variants, counts);
});

const collectTotal = () => {
    let total = 0;
    Array.from(T('input.combine-select-input:checked')).forEach(el => {
        const id = el.dataset.target,
              qty = T(`#qtyCount${id}${BLOCK.ID}`)[0].value,
              price = T(`#current-price${id}${BLOCK.ID} .product-price`)[0].innerText.replace(/\./g,"").replace(",",".");
        total += parseFloat(price) * parseFloat(qty);
    });
    T(`#combine-total-${BLOCK.ID}`).html(T.format(total));
}

window[`qty${BLOCK.ID}`] = (count, oldCount, qty) => {
    collectTotal();
}

T('.variant-wrapper select').on('change', () => {
    setTimeout(() => { 
        collectTotal();
    }, 500);   
});

T('input.combine-select-input').on('change', () => {
    collectTotal();
});