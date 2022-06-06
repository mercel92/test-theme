<div id="product-quick-view" class="col-12" v-cloak>
    <div class="row mb-1">
        <div id="product-left" class="col-12 col-md-6 py-1">
            <div id="product-detail-images-wrapper-quick" class="w-100 h-100 position-relative product-detail-images-wrapper">
                <div class="w-100 position-relative mb-1 product-detail-images">
                    <div :id="'product-detail-slider-' + P.ID" class="swiper-container">
                        <div class="swiper-wrapper" :id="'gallery-' + P.ID">
                            <a class="swiper-slide slide-item" :data-id="IMAGE.VARIANT_TYPE_ID" :href="IMAGE.BIG" v-for="IMAGE in P.IMAGE_LIST">
                                <div class="image-wrapper">
                                    <figure class="image-inner">
                                        <img :src="IMAGE.MEDIUM" :alt="P.TITLE">
                                    </figure>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div :id="'swiper-pagination-' + P.ID" class="swiper-pagination bottom"></div>
                    <div :id="'swiper-prev-' + P.ID" class="swiper-button-prev"><i class="ti-arrow-left"></i></div>
                    <div :id="'swiper-next-' + P.ID" class="swiper-button-next"><i class="ti-arrow-right"></i></div>
                </div>
                <div class="col-12 position-relative product-thumb-slider-wrapper" v-if="P.IMAGE_COUNT > 1">
                    <div :id="'product-thumb-slider-' + P.ID" class="swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide slide-item w-25" :data-id="IMAGE.VARIANT_TYPE_ID" v-for="IMAGE in P.IMAGE_LIST">
                                <div class="image-wrapper">
                                    <figure class="image-inner">
                                        <img :src="IMAGE.SMALL" :alt="P.TITLE">
                                    </figure>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div :id="'swiper-thumb-prev-' + P.ID" class="swiper-button-prev"><i class="ti-arrow-left"></i></div>
                    <div :id="'swiper-thumb-next-' + P.ID" class="swiper-button-next"><i class="ti-arrow-right"></i></div>
                </div>
            </div>
        </div>
        <div id="product-right" class="col-12 col-md-6 py-1">
            <h1 id="product-title" class="text-color fw-semibold">{{ P.TITLE }}</h1>
            <div class="row align-items-center" v-if="P.MODEL != '' || P.SUPPLIER_PRODUCT_CODE != ''">
                <div id="product-code" class="col-12 col-sm-auto mr-auto text-body mt-1" v-if="P.SUPPLIER_PRODUCT_CODE != ''">
                    {#product_code#} : <span id="supplier-product-code" class="text-primary fw-bold">{{ P.SUPPLIER_PRODUCT_CODE }}</span>
                </div>
                <div class="col-12 col-sm-auto d-flex align-items-center model-info mt-1" v-if="P.MODEL != ''">
                    <a :href="P.MODEL_URL" id="model-title" :title="P.MODEL" class="d-block text-body">
                        {#model#} : <span class="text-primary fw-bold">{{ P.MODEL }}</span>
                    </a>
                </div>
            </div>
            <div class="w-100 py-1" v-if="P.SHOW_VENDOR == 1 && P.IS_DISPLAY_PRODUCT == 1">
                Ürünün fiyatını görmek için <a :href="'/' + PAGE_LINK.LOGIN" class="fw-bold text-primary text-underline">bayi girişi</a> yapınız.
            </div>
            <div class="w-100 p-1 mt-1 pt-1 border-top border-bottom" v-if="P.IS_DISPLAY_PRODUCT == 0">
                <div class="row align-items-center justify-content-between">
                    <div class="clearfix price-wrapper d-flex flex-wrap">
                        <div class="pr-1 text-delete text-gray fw-light product-discounted-price" :class="{'d-none' : P.IS_DISCOUNT_ACTIVE != 1}" :data-old="P.PRICE_BUY"
                        v-if="P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1">
                            <div v-if="P.DISPLAY_VAT == 1">
                                <span class="product-price-not-discounted">{{ vat(P.PRICE_NOT_DISCOUNTED, P.VAT) }}</span> {{ P.TARGET_CURRENCY }}
                            </div>
                            <div v-else>
                                <span class="product-price-not-discounted-not-vat">{{ format(P.PRICE_NOT_DISCOUNTED) }}</span> {{ P.TARGET_CURRENCY }} + {#vat#}
                            </div>
                        </div>
                        <div class="product-current-price" :data-old="P.BUY">
                            <div v-if="P.DISPLAY_VAT == 1">
                                <span class="fw-black product-price">{{ vat(P.PRICE_SELL, P.VAT) }}</span> {{ P.TARGET_CURRENCY }}
                            </div>
                            <div v-else>
                                <span class="fw-black product-price-not-vat">{{ format(P.PRICE_SELL) }}</span> {{ P.TARGET_CURRENCY }} + {#vat#}
                            </div>
                        </div>
                    </div>
                    <div class="bg-primary text-white border-round discounted-badge" :class="{'d-none' : P.DISCOUNT_PERCENT <= 0}"
                    v-if="P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1">
                        %<span class="fw-black product-discount">{{ P.DISCOUNT_PERCENT }}</span>&nbsp;{#discount#}
                    </div>
                </div>
                <div class="row" v-if="P.IS_MONEY_ORDER_ACTIVE == true">
                    <div class="product-money-price mt-1">
                        {#money_price#} :
                        <span v-if="P.DISPLAY_VAT == 1">
                            <span class="fw-black money-order-price">{{ vat(P.PRICE_MONEY_ORDER, P.VAT) }}</span> {{ P.TARGET_CURRENCY }}
                        </span>
                        <span v-else>
                            <span class="fw-black money-order-price-not-vat">{{ format(P.PRICE_MONEY_ORDER) }}</span> {{ P.TARGET_CURRENCY }} + {#vat#}
                        </span>
                        <span class="product-money-discount-percent text-primary ml-1" v-if="P.MONEY_ORDER_PERCENT != 0">
                            <span class="fw-black money-discount">
                                %{{ P.MONEY_ORDER_PERCENT < 0 ? P.MONEY_ORDER_PERCENT * -1 : P.MONEY_ORDER_PERCENT }}
                            </span>&nbsp;{#discount#}
                        </span>
                    </div>
                </div>
                <div class="row mt-1 align-items-center">
                    <div class="col-12 col-sm-auto mr-auto p-0" v-if="P.BRAND != ''">
                        {#more#} <a :href="P.BRAND_URL" class="text-primary fw-bold">{{ P.BRAND }}</a>
                    </div>
                    <div class="col-12 col-sm-auto p-0">
                        {#more#} <a :href="P.CATEGORY_URL" class="text-primary fw-bold">{{ P.CATEGORY_NAME }}</a>
                    </div>
                </div>
            </div>
            <div class="w-100 py-1 border-bottom" v-if="P.SHORT_DESCRIPTION || P.DOCUMENT_INFO">
                <div v-if="P.SHORT_DESCRIPTION != ''">
                    <div class="text-body fw-bold sub-title">{#short_description#}</div>
                    <div class="text-body" v-html="P.SHORT_DESCRIPTION"></div>
                </div>
                <div class="text-body fw-bold" :class="{'mt-1' : P.SHORT_DESCRIPTION != ''}" v-if="P.DOCUMENT_INFO != ''" v-html="P.DOCUMENT_INFO"></div>
            </div>
            <div class="w-100" v-if="P.IS_DISPLAY_PRODUCT == 0">
                <input type="hidden" :name="'subProQuick' + P.ID" :id="'subProQuick' + P.ID" value="0" />
                <div class="w-100 border-bottom position-relative popover-wrapper" v-if="P.HAS_VARIANT == 1">
                    <div class="variant-overlay" :data-id="P.ID"></div>
                    <div class="w-100 py-1 variant-wrapper" :data-product="P.ID">
                        <textarea :id="'jsonQuick' + P.ID" class="d-none">{{ P.VARIANT_DATA }}</textarea>
                        <div class="row">
                            <div class="col-12 sub-product-list" v-if="P.VARIANT_FEATURE1_LIST.length > 0">
                                <div class="w-100 text-body fw-bold feature-title" v-if="P.VARIANT_FEATURE1_TITLE">{{ P.VARIANT_FEATURE1_TITLE }} : <span id="sub-one-select"></span></div>
                                <div class="w-100 text-body fw-bold feature-title" v-else>{#choose#} : <span id="sub-one-select"></span></div>
                                <div class="w-100 sub-one">
                                    <div class="col-12 p-0">
                                        <div class="row m-0">
                                            <a href="javascript:void(0);"
                                                :data-id="SUB.TYPE_ID"
                                                :data-subproduct-id="SUB.ID"
                                                :data-pid="P.ID"
                                                :data-type="SUB.TYPE"
                                                :data-code="SUB.CODE"
                                                :data-price="SUB.PRICE"
                                                :data-stock="SUB.STOCK"
                                                :data-barcode="SUB.BARCODE"
                                                :data-mop="SUB.MONEY_ORDER_PERCENT"
                                                :data-vat="SUB.VAT"
                                                :data-not-discounted="SUB.PRICE_NOT_DISCOUNTED"
                                                :data-target="'Quick' + P.ID"
                                                data-group-id="1"
                                                data-toggle="variant"
                                            class="d-inline-block border p-1 border-round sub-button-item"
                                                :class="{
                                                    'mr-1' : index != P.VARIANT_FEATURE1_LIST.length -1, 
                                                    'selected' : SUB.TYPE_ID == P.VARIANT_FEATURE1_SELECTED, 
                                                    'passive' : SUB.IN_STOCK == false }" v-for="(SUB, index) in P.VARIANT_FEATURE1_LIST">
                                                <span>{{ SUB.TYPE }}</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 sub-product-list" :class="P.VARIANT_FEATURE1_LIST.length > 0 ? 'mt-1' : ''"  v-if="P.VARIANT_FEATURE2_LIST.length > 0">
                                <div class="w-100 text-body fw-bold feature-title" v-if="P.VARIANT_FEATURE2_TITLE">{{ P.VARIANT_FEATURE2_TITLE }} : <span id="sub-two-select"></span></div>
                                <div class="w-100 text-body fw-bold feature-title" v-else>{#choose#} : <span id="sub-two-select"></span></div>
                                <div class="w-100 sub-two">
                                    <div class="col-12 p-0">
                                        <div class="row m-0">
                                            <a href="javascript:void(0);"
                                            :data-id="SUB.TYPE_ID"
                                            :data-subproduct-id="SUB.ID"
                                            :data-pid="P.ID"
                                            :data-type="SUB.TYPE"
                                            :data-code="SUB.CODE"
                                            :data-price="SUB.PRICE"
                                            :data-stock="SUB.STOCK"
                                            :data-barcode="SUB.BARCODE"
                                            :data-mop="SUB.MONEY_ORDER_PERCENT"
                                            :data-vat="SUB.VAT"
                                            :data-not-discounted="SUB.PRICE_NOT_DISCOUNTED"
                                            :data-target="'Quick' + P.ID"
                                            data-group-id="2"
                                            data-toggle="variant"
                                            class="d-inline-block border p-1 border-round sub-button-item"
                                                :class="{
                                                    'mr-1' : index != P.VARIANT_FEATURE2_LIST.length -1, 
                                                    'selected' : SUB.TYPE_ID == P.VARIANT_FEATURE2_SELECTED, 
                                                    'passive' : SUB.IN_STOCK == false }" v-for="(SUB, index) in P.VARIANT_FEATURE2_LIST">
                                                <span>{{ SUB.TYPE }}</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="w-100 p-1 pr-0 pb-0 in-stock-available">
                    <div class="row align-items-flex-end product-add-buttons">
                        <div class="col-6 col-sm-2 col-md-12 col-lg-2 pl-0 d-flex flex-wrap align-items-flex-end mb-1">
                            <label class="d-block w-100 small-text text-uppercase" v-if="P.STOCK_UNIT != ''">{{ P.STOCK_UNIT }}</label>
                            <label class="d-block w-100 small-text text-uppercase" v-else>{#count#}</label>
                            <div class="w-100 qty" v-bind:class="'qty' + P.ID" data-toggle="qty" v-bind:data-multiple="P.IS_MULTIPLE_DISCOUNT_ACTIVE == 1 ? 'true' : 'false'">
                                <span class="ti-minus"></span>
                                <span class="ti-plus"></span>
                                <input type="number" class="form-control no-arrows text-center" :id="'ProductCountQuick' + P.ID" :name="'ProductCountQuick' + P.ID" :min="P.MIN_ORDER_COUNT" :step="P.STOCK_INCREMENT" :value="P.MIN_ORDER_COUNT">
                            </div>
                        </div>
                        <div class="col-12 col-sm-8 col-md-12 col-lg-8 mb-1">
                            <div class="row">
                                <div class="col-7 pl-0">
                                    <button id="addToCartBtn" class="w-100 btn btn-primary px-0 text-uppercase" @click="addToCart(P.ID, 'subProQuick' + P.ID, 'ProductCountQuick' + P.ID)">
                                        {#add_cart#}
                                    </button>
                                </div>
                                <div class="col-5 pl-0">
                                    <button id="fastAddToCartBtn" class="w-100 btn btn-dark px-0 text-uppercase" @click="addToCart(P.ID, 'subProQuick' + P.ID, 'ProductCountQuick' + P.ID, 1)">{#buy_now#}</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-2 col-md-12 col-lg-2 pl-0 mb-1">
                            <a href="javascript:void(0);" :data-id="P.ID" id="addToFavBtn" data-toggle="tooltip" data-title="{#like#}" class="w-100 d-flex align-items-center justify-content-center btn border border-light px-0 add-favourite-btn">
                                <i class="ti-heart-o ease"></i>
                                <span class="d-sm-none d-md-block d-lg-none ml-1">{#like#}</span>
                            </a>
                        </div>
                    </div>
                    <div class="row product-subscribe border border-round border-light my-1 mr-0" v-if="P.SUBSCRIBE == 1">
                        <input type="checkbox" :id="'product-subscribe-' + P.ID" class="form-control" :data-discount="P.SUBSCRIBE_DISCOUNT_RATE" data-toggle="subscribe">
                        <label :for="'product-subscribe-' + P.ID" class="col-12 col-sm-6 border-right py-1 d-flex align-items-center m-0 fw-bold">
                            <span class="input-checkbox"><i class="ti-check"></i></span>
                            {#subscribe#}
                        </label>
                        <select :id="'product-subscribe-frequency-' + P.ID" class="col-12 col-sm-6 form-control h-100 py-1 border-0" name="subscribe_frequency">
                            <option value="">{#choose_subscriber#}</option>
                            <option :value="FREQUENCY" v-for="FREQUENCY in P.SUBSCRIBE_FREQUENCY_LIST"> {{ FREQUENCY }}</option>
                        </select>
                    </div>
                    <div class="row mb-1 pb-1 border-bottom" v-if="P.DELIVERY_DAY">
                        <span class="text-content text-primary fw-bold">{{ P.DELIVERY_DAY }} {#day#}</span>&nbsp;{#delivey_info#}
                    </div>
                </div>
                <div class="w-100 p-1 pr-0 out-stock-available d-none">
                    <div class="row">
                        <div class="col-12 py-1 bg-light text-body">
                            <p>{#out_of_stock#}</p>
                            <a :href="'/srv/service/content-v5/sub-folder/3/1004/stock-alarm/?product=' + P.ID + '&variant=' + P.VARIANT_ID"
                                class="text-body fw-bold popupwin"
                                data-type="stock"
                                v-if="IS_MEMBER_LOGGED_IN == true">{#stock_alert#}</a>
                            <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" class="text-body fw-bold popupwin" v-else>{#stock_alert#}</a>
                        </div>
                    </div>
                </div>
                <div id="product-multiple-discount" class="w-100 border border-bottom-0 border-right-0 border-2x border-round mb-1 product-multiple-discount" v-if="P.IS_MULTIPLE_DISCOUNT_ACTIVE == 1">
                    <div class="col-12 p-10 fw-semibold product-multiple-title d-flex align-items-center justify-content-between border-right border-2x">
                        {#multiple_discount#}
                    </div>
                    <div class="col-12 border-top border-2x product-multiple-list">
                        <div class="row">
                            <div class="col-12 col-sm-2 p-0 d-flex d-sm-block sm-flex-wrap">
                                <div class="col-6 col-sm-12 p-10 text-center text-content border-bottom border-right border-2x h-sm-50">{#amount#}</div>
                                <div class="col-6 col-sm-12 p-10 text-center text-content border-bottom border-right border-2x h-sm-50">{#discount#}</div>
                            </div>
                            <div class="col-12 col-sm-10 p-0 d-flex sm-flex-wrap product-multiple-scroll">
                                <div class="col-12 p-0 text-center text-content d-flex d-sm-block product-multiple-item" :data-min="M_D.MIN" :data-max="M_D.MAX" :data-percent="M_D.PERCENT" v-for="M_D in P.MULTIPLE_DISCOUNT">
                                    <div class="col-6 col-sm-12 p-10 border-bottom border-right border-2x d-flex align-items-center justify-content-center h-sm-50"><span>{{ M_D.MIN }}</span> - <span>{{ M_D.MAX }}</span></div>
                                    <div class="col-6 col-sm-12 p-10 border-bottom border-right border-2x d-flex align-items-center justify-content-center h-sm-50">%{{ M_D.PERCENT }}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
let DATA = {};
try {
    DATA = {$DATA};
} catch (ex) {
    DATA = {}
}

const quickView = {
    data() {
        return {
            data: DATA,
            P: DATA.P,
            TARGET_CURRENCY: DATA.TARGET_CURRENCY,
            IS_MEMBER_LOGGED_IN: MEMBER_INFO > 0,
            PAGE_LINK: PAGE_LINK,
        }
    },
    methods : {
        format(p) {
            return T.format(p);
        },
        vat(p, vat) {
            return T.vat(p, vat);
        },
        addToCart(pid, sub, count) {
            addToCart(pid, document.getElementById(sub).value, document.getElementById(count).value);
        },
    },
    mounted() {
        const self = this;
        const P = self.P;
        setTimeout(() => {
            initComponents();

            if (P.IMAGE_COUNT > 1) {
                var thumb = new Swiper(`#product-thumb-slider-${P.ID}`, {
                    spaceBetween: T.isMobile() ? 15 : 30,
                    slidesPerView: 4,
                    watchSlidesVisibility: true,
                    watchSlidesProgress: true,
                    navigation: {
                        nextEl: `#swiper-thumb-next-${P.ID}`,
                        prevEl: `#swiper-thumb-prev-${P.ID}`,
                    },
                });
            }
   
            var slide = new Swiper(`#product-detail-slider-${P.ID}`, {
                navigation: {
                    nextEl: `#swiper-next-${P.ID}`,
                    prevEl: `#swiper-prev-${P.ID}`,
                },
                pagination: {
                    el: `#swiper-pagination-${P.ID}`,
                    clickable: true
                },
                thumbs: {
                    swiper: P.IMAGE_COUNT > 1 ? thumb : '',
                },
                observer : true,
                observeSlideChildren: true,
                observeParents: true,
            });

            const variantTitle = () => {
                const selecteds = T('.sub-product-list .selected');
                Array.from(selecteds).forEach(item => {
                    const wrapper = item.closest('.sub-one') ? 'sub-one' : 'sub-two';
                    const title = item.dataset.title;
                    T(`#${wrapper}-select`).text(title);
                });
            };

            Array.from(T('.sub-product-list a, .sub-product-list select')).forEach(element => {
                let event = 'click';
                if(element.nodeName == 'SELECT') event = 'change';

                T(element).on(event, () => { variantTitle(); });
            });
            variantTitle();

            const gallery = T(`#gallery-${P.ID}`);
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

            const subOne = T('#product-quick-view #product-right .sub-one')[0];
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
                    const wrapItem = T('#product-detail-images-wrapper-quick')[0],
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
                    if (P.IMAGE_COUNT > 1) thumb.update();
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
            if (typeof QuickViewObj != 'undefined') {
                for (var i = 0; i < QuickViewObj.callback.open.length; i++) {
                    if (typeof QuickViewObj.callback.open[i] == 'function') {
                        QuickViewObj.callback.open[i](P);
                    }
                }
            }
        }, 150);
    },
};
Vue.createApp(quickView).mount('#product-quick-view');
</script>