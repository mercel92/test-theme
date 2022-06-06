<div id="popup-cart" class="col-12 py-2" v-cloak>
    <div class="col-12">
        <div class="row">
            <div class="col-12 mb-1 border-bottom border-secondary">
                <div class="row align-items-center product-cart-title fw-bold">
                    {{ data.GET_MULTI == 'true' ? '{#products_added_cart#}' : '{#product_added_cart#}' }} <i class="ml-1 ti-check text-success"></i>
                </div>
            </div>
            <div class="col-12 cart-list">
                <div class="row">
                    <div class="col-12 py-1 mb-1 border border-round position-relative cart-item" v-for="P in data.PRODUCTS">
                        <div class="row">
                            <div class="col-3">
                                <div class="image-wrapper">
                                    <figure class="image-inner">
                                        <img :src="P.IMAGE.SMALL" :alt="P.TITLE + ' ' + P.VARIANT_NAME">
                                    </figure>
                                </div>
                            </div>
                            <div class="col-9 pl-0">
                                <div class="brand fw-bold" v-html="P.BRAND" v-if="P.BRAND != ''"></div>
                                <div class="title" v-html="P.TITLE + ' ' + P.VARIANT1_NAME + ' ' + P.VARIANT2_NAME"></div>
                                <div class="w-100 d-flex align-items-flex-end">
                                    <div class="price-wrapper" v-if="P.DISPLAY_VAT == 0">
                                        <del class="text-gray text-delete price-old" v-if="P.PRICE_NOT_DISCOUNTED != P.PRICE_SELL">{{ format(P.PRICE_NOT_DISCOUNTED) }} {{ P.TARGET_CURRENCY }} + %{{P.VAT}} {#vat#}</del>
                                        <div class="current-price text-primary"><span class="fw-black">{{ format(P.PRICE_SELL) }} {{ P.TARGET_CURRENCY }}</span> + %{{P.VAT}} {#vat#}</div>
                                    </div>
                                    <div class="price-wrapper" v-else>
                                        <del class="text-gray text-delete price-old" v-if="P.PRICE_NOT_DISCOUNTED != P.PRICE_SELL">{{ vat(P.PRICE_NOT_DISCOUNTED, P.VAT) }} {{ P.TARGET_CURRENCY }}</del>
                                        <div class="current-price fw-black text-primary">{{ vat(P.PRICE_SELL, P.VAT) }} {{ P.TARGET_CURRENCY }}</div>
                                    </div>
                                    <div class="pl-1 count-info text-black">
                                        {{ P.COUNT }} {{ P.STOCK_UNIT }}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 mb-1 cart-related-products" v-if="data.RELATED_PRODUCTS.length > 0">
                <div class="row">
                    <div class="col-12 px-0 mb-1 border-bottom border-secondary">
                        <div class="product-cart-description">
                            {#popup_cart_description_1#}, <strong class="text-primary">{#popup_cart_description_2#}</strong> {#popup_cart_description_3#} !
                        </div>
                    </div>
                    <div class="col-12 px-0">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide product-item" v-for="product in data.RELATED_PRODUCTS">
                                    <div class="w-100 h-100 position-relative bg-white ease border border-round d-flex flex-direction-column justify-content-between">
                                        <a :href="'/' + product.URL" class="image-wrapper">
                                            <figure class="image-inner">
                                                <img :src="product.IMAGE.SMALL" :alt="product.TITLE">
                                            </figure>
                                        </a>
                                        <div class="col-12 border-top d-flex flex-direction-column justify-content-between">
                                            <a :href="'/' + product.BRAND_URL" class="w-100 d-block fw-bold text-body brand-title">{{ product.BRAND }}&nbsp;</a>
                                            <a :href="'/' + product.URL" class="w-100 product-title">{{ product.TITLE }}</a>
                                            <div class="w-100 product-price-wrapper" v-if="product.IS_DISPLAY_PRODUCT == 0">
                                                <div class="discounted-price text-delete" v-if="product.DISCOUNT_PERCENT > 0 && product.IS_DISPLAY_DISCOUNTED_ACTIVE == 1">{{ vat(product.PRICE_NOT_DISCOUNTED, product.VAT) }} {{ product.TARGET_CURRENCY }}</div>
                                                <div class="current-price">
                                                    <div v-if="product.DISPLAY_VAT === '1'"><strong class="fw-black">{{ vat(product.PRICE_SELL, product.VAT) }}</strong> {{ product.TARGET_CURRENCY }}</div>
                                                    <div v-else><strong>{{ format(product.PRICE_SELL) }}</strong class="fw-black"> {{ product.TARGET_CURRENCY }} <i class="ti-plus"></i> {#vat#}</div>
                                                </div>
                                            </div>
                                            <div class="w-100 pt-1 product-buttons" v-if="product.IS_DISPLAY_PRODUCT == 0">
                                                <a href="javascript:void(0);" 
                                                class="w-100 btn btn-sm btn-outline-gray text-center text-bold border-round" 
                                                title="{#add_cart#}"
                                                @click="addCart(product.ID, product.VARIANT_ID, 1)">
                                                    <i class="ti-basket"></i>
                                                    {#add_cart#}
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 p-0">
                <div class="row">
                    <div class="col-12 col-md-6 pb-1">
                        <a id="cart-popup-continue-shopping" href="javascript:void(0);" class="w-100 btn btn-dark text-uppercase" @click="close">{#continue_shopping#}</a>
                    </div>
                    <div class="col-12 col-md-6 pb-1">
                        <a id="cart-popup-go-cart" href="/{url type='page' id='30'}" class="w-100 btn btn-primary text-uppercase">{#go_cart#}</a>
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
        DATA = {};
    }

    const PopupCart = {
        data() {
            return {
                data: DATA
            }
        },
        methods: {
            addCart(pId, subId, count) {
                addToCart({
                    productId: pId, 
                    variantId: subId, 
                    quantity: count,
                    relatedProductId: `${this.data.GET_PRODUCT}:${this.data.VARIANT_ID}`
                });
            },
            vat(p, vat) {
                return T.vat(p, vat);
            },
            format(p) {
                return T.format(p);
            },
            close() {
                T('.t-modal-close').trigger('click');
            },
        },
        mounted() {
            setTimeout(() => {
                initComponents();
                if(this.data.RELATED_PRODUCTS.length > 0) {
                    new Swiper(T('.cart-related-products .swiper-container')[0], {
                        slidesPerView: T.isMobile() ? 2 : 4,
                        spaceBetween: T.isMobile() ? 8 : 15,
                        pagination: {
                            el: '.swiper-pagination',
                            clickable: true
                        },
                        breakpoints: {
                            576: {
                                slidesPerView: 2
                            },
                            768: {
                                slidesPerView: 3
                            },
                            970: {
                                slidesPerView: 4
                            }
                        }
                    });
                }
             }, 150);
        }
    };

    Vue.createApp(PopupCart).mount('#popup-cart');
</script>