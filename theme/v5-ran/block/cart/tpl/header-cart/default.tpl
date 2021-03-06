<div id="header-cart" class="w-100" v-cloak>
    <div class="w-100" v-if="data.PRODUCTS.length > 0">
        <div class="col-12 header-cart-item border mb-1 position-relative" v-for="(P, index) in data.PRODUCTS">
            <div class="row">
                <div class="col-5 p-0 d-flex align-items-center border-right">
                    <span class="image-wrapper">
                        <picture class="image-inner">
                            <img :src="P.IMAGE.SMALL" :alt="P.TITLE + ' - ' + P.VARIANT_NAME">
                        </picture>
                    </span>
                </div>
                <div class="col p-1">
                    <div class="cp-brand fw-bold" v-if="P.BRAND != ''">{{ P.BRAND }}</div>
                    <div class="cp-title mb-1">{{ P.TITLE }} <span v-if="P.VARIANT1_NAME"> {{ P.VARIANT1_NAME }}</span> <span v-if="P.VARIANT2_NAME">{{ P.VARIANT2_NAME }}</span></div>                    
                    <div class="w-100 d-flex">
                        <div v-if="P.DISPLAY_VAT == '1'">
                            <div class="price-discount text-gray text-delete" v-if="P.DISCOUNT_PERCENT > 0 && P.IS_DISPLAY_DISCOUNTED_ACTIVE">
                                {{ vat(P.PRICE_NOT_DISCOUNTED, P.VAT) }} {{ P.TARGET_CURRENCY }}
                            </div>
                            <div class="price-sell fw-bold">{{ vat(P.PRICE_SELL, P.VAT) }} {{ P.TARGET_CURRENCY }}</div>
                        </div>
                        <div v-if="P.DISPLAY_VAT != '1'">
                            <div class="price-discount text-gray text-delete" v-if="P.DISCOUNT_PERCENT > 0 && P.IS_DISPLAY_DISCOUNTED_ACTIVE">
                                {{ format(P.PRICE_NOT_DISCOUNTED) }} {{ P.TARGET_CURRENCY }} + {#vat#}
                            </div>
                            <div class="price-sell fw-bold">{{ format(P.PRICE_SELL) }} {{ P.TARGET_CURRENCY }} + {#vat#}</div>
                        </div>
                    </div>
                </div>
                <div class="col-12 border-top">
                    <div class="row">
                        <div class="col-5 p-0 d-flex align-items-center justify-content-evenly border-right header-cart-buttons">
                            <div class="col-auto">
                                <a href="javascript:void(0);" class="text-body" data-toggle="tooltip" data-title="Sil" @click="deleteItem(P)">
                                    <i class="ti-trash-o"></i>
                                </a>
                            </div>
                            <div class="col-auto">
                                <a href="javascript:void(0);" class="text-body add-favourite-btn" data-toggle="tooltip" data-title="Be??en" :data-id="P.ID">
                                    <i class="ti-heart-o"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col p-0 bg-light">
                            <div class="qty w-100" data-toggle="qty" 
                                data-callback="qtyIncreaseHeaderCart" 
                                :data-increment="P.STOCK_INCREMENT"
                                :data-pid="index">
                                <span :id="'qtyHeaderCart-minus' + P.ID + P.CART_ID" class="ti-minus" @click="P.COUNT == 1 ? deleteItem(P) : ''" :class="{'ti-trash-o' : P.COUNT == 1}"></span>
                                <input type="number"
                                    :id="'qtyHeaderCart' + P.ID + P.CART_ID" 
                                    :min="P.MIN_ORDER_COUNT" 
                                    :max="P.STOCK" 
                                    :step="P.STOCK_INCREMENT" 
                                    v-model="P.COUNT" 
                                    class="form-control text-center no-arrows">
                                <span :id="'qtyHeaderCart-plus' + P.ID + P.CART_ID" class="ti-plus"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 border-top mt-2 pt-2">
            <div class="row align-items-center header-cart-price-line">
                <div class="col-5 p-0">{#cart_total#}</div>
                <div class="col-1 p-0 text-center">:</div>
                <div class="col-6 p-0 text-right">{{ format(data.PRICE_CART) }} {{ data.TARGET_CURRENCY }}</div>
            </div>
            <div class="row align-items-center header-cart-price-line">
                <div class="col-5 p-0">{#cargo_price#}</div>
                <div class="col-1 p-0 text-center">:</div>
                <div class="col-6 p-0 text-right">{{ format(data.PRICE_CARGO) }} {{ data.TARGET_CURRENCY }}</div>
            </div>
            <div class="row align-items-center fw-bold header-cart-price-line">
                <div class="col-5 p-0">{#general_price#}</div>
                <div class="col-1 p-0 text-center">:</div>
                <div class="col-6 p-0 text-right">{{ format(data.PRICE_GENERAL) }} {{ data.TARGET_CURRENCY }}</div>
            </div>
        </div>
        <a href="/{url type='page' id='30'}" id="go-cart-btn" class="col-12 btn btn-md btn-primary d-flex align-items-center justify-content-between text-center text-uppercase">
            {#buy#} <i class="ti-arrow-right"></i>
        </a>
    </div>
    <div class="w-100" v-else>
        <div class="text-center fw-bold no-products">{#empty_cart#}.</div>
    </div>
</div>
<script>
    let DATA = {};
    try {
        DATA = {$DATA};
    } catch (ex) {
        DATA = {};
    }

    var HeaderCart = Vue.createApp({
        data() {
            return {
                data: DATA,
                srv: `/srv/service/content-v5/data/30/1054/header-cart`,
            }
        },
        methods: {
            format(p) {
                return T.format(p);
            },
            vat(p, vat) {
                return T.vat(p, vat);
            },
            deleteItem(product = {}) {
                if(product.CART_ID < 0) return;
                const self = this;
                Cart.delete(product.CART_ID, result => {
                    self.load();
                    if (result.status > 0) {
                        T('.cart-soft-count').text(result.totalQuantity);
                        T('.cart-soft-price').text(result.totalPrice);
    
                        if (typeof mobileApp !== 'undefined') {
                            try { mobileApp.changedCartCount(result.totalQuantity); } 
                            catch (err) { }
                        }
    
                        if (typeof webkit !== 'undefined') {
                            try { webkit.messageHandlers.callbackHandler.postMessage(result.totalQuantity); } 
                            catch (err) { }
                        }
                    }
                });
            },
            load() {
                const self = this;
                axios.get(self.srv).then(response => {
                    const result = response.data;
                    self.data = result.DATA;
                    self.favourite();
                });
            },
            favourite() {
                const self = this;
                if (self.data.PRODUCTS.length > 0) {
                    favouriteProducts.set();
                }
            },
        },
        mounted() {
            initComponents();
            this.favourite();
        }
    });

    var HeaderCartVue = HeaderCart.mount('#header-cart');

    window['qtyIncreaseHeaderCart'] = function(value, oldVal, qty) {
        const product = HeaderCartVue.data.PRODUCTS[qty.dataset.pid];
        qty.setAttribute('disabled', true);
        Cart.update(product.CART_ID, value, result => {
            HeaderCartVue.load();
            if (result.status > 0) {
                T('.cart-soft-count').text(result.totalQuantity);
                T('.cart-soft-price').text(result.totalPrice);
            } else {
                if (T('#modal-popup-qty-error').length < 1) {
                    T.modal({
                        id: 'modal-popup-qty-error',
                        html: result.statusText,
                    });
                    T(`#qtyHeaderCart${product.ID}${qty.dataset.pid}`)[0].setAttribute('disabled', true);
                }
            }
            qty.removeAttribute('disabled');
            T(`#qtyHeaderCart${product.ID}${qty.dataset.pid}`)[0].removeAttribute('disabled');
        });
    }
</script>