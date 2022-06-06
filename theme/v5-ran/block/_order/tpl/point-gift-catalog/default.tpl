<div id="gift-catalog" class="col-12 py-1" v-cloak>
    <div class="w-100" v-if="promotions.length > 0">
        <div class="border-bottom block-title position-relative mb-1">
            <strong>{#selected_products#}</strong>
        </div>
        <div class="row">
            <div class="col-6 col-sm-4 col-md-3 col-lg-2 product-item mb-1" v-for="(P, i) in promotions">
                <div class="w-100 h-100 d-flex flex-direction-column justify-content-between bg-white ease border border-round">
                    <div class="w-100 position-relative">
                        <div class="image-wrapper">
                            <span class="image-inner">
                                <img :data-src="'/Data/K/' + P.image" :alt="P.name + '-' + P.brand" class="lazyload" loading="lazy">
                            </span>
                        </div>
                    </div>
                    <div class="col-12 py-1 promotions-product-detail-card product-detail-card">
                        <div class="row">
                            <div class="col-12 fw-bold text-body brand-title" v-html="P.brand" v-if="P.brand != ''"></div>
                            <div class="col-12 product-title" v-html="P.name"></div>
                            <div class="col-12 pb-1 product-bottom-line">
                                <div class="row">
                                    <div class="col-12 product-price-wrapper d-flex mb-8">
                                        <span class="fw-bold text-primary"> {{ P.point }} {#point#} </span>
                                    </div>
                                    <div class="col-12 d-flex">
                                        <div class="qty" :class="'qty' + P.cartItemNo" data-toggle="qty" :data-id="P.cartItemNo" data-callback="updateQty">
                                            <span class="ti-minus"></span>
                                            <span class="ti-plus"></span>
                                            <input type="number" class="form-control no-arrows text-center" :id="'ProductCountGift' + P.cartItemNo" :name="'ProductCountGift' + P.cartItemNo" :value="P.count">
                                        </div>
                                        <a :id="'product-remove-button-' + P.cartItemNo" class="border border-round remove-cart-btn ml-auto" href="javascript:void(0);" title="Kaldır" @click="remove(P.cartItemNo)"><i class="ti-close"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="w-100" v-if="products.length > 0">
        <div class="border-bottom block-title position-relative mb-1">
            <strong>{#select_product#}</strong>
        </div>
        <div class="row">
            <div class="col-6 col-sm-4 col-md-3 col-lg-2 product-item mb-1" v-for="(P, i) in products">
                <div class="w-100 h-100 d-flex flex-direction-column justify-content-between bg-white ease border border-round">
                    <div class="w-100 position-relative">
                        <a :href="'/' + P.URL" class="image-wrapper">
                            <span class="image-inner">
                                <img :data-src="P.IMAGE.SMALL" :alt="P.TITLE + '-' + P.BRAND" class="lazyload" loading="lazy">
                            </span>
                        </a>
                    </div>
                    <div class="col-12 py-1 product-detail-card">
                        <div class="row">
                            <a :href="'/' + P.BRAND_URL" class="col-12 fw-bold text-body brand-title" v-html="P.BRAND" v-if="P.BRAND != ''"></a>
                            <a :href="'/' + P.URL" class="col-12 product-title" v-html="P.TITLE + P.VARIANT_NAME"></a>
                            <div class="col-12 pb-1 product-bottom-line" v-if="P.IS_DISPLAY_PRODUCT == 0">
                                <div class="row">
                                    <div class="col-12 product-price-wrapper d-flex mb-8">
                                        <span class="fw-bold text-primary"> {{ P.POINT }} {#point#} </span>
                                    </div>
                                    <div class="col-12 mb-8">
                                        <textarea maxlength="1000" name="orderNote" :id="'noteGift' + P.ID" class="form-control form-control-sm order-note" placeholder="{#note#}:"></textarea>
                                    </div>
                                    <input type="hidden" :name="'subProGift' + P.ID" :id="'subProGift' + P.ID" value="0" />
                                    <div class="col-12 d-flex">
                                        <div class="qty" :class="'qty' + P.ID" data-toggle="qty">
                                            <span class="ti-minus"></span>
                                            <span class="ti-plus"></span>
                                            <input type="number" class="form-control no-arrows text-center" :id="'ProductCountGift' + P.ID" :name="'ProductCountGift' + P.ID" :min="P.MIN_ORDER_COUNT" :step="P.STOCK_INCREMENT" :value="P.MIN_ORDER_COUNT">
                                        </div>
                                        <a :id="'product-addcart-button-' + P.ID" class="border border-round add-to-cart-btn ml-auto" href="javascript:void(0);" title="Sepete Ekle" @click="addToCart(P.ID, 'subProGift' + P.ID, 'ProductCountGift' + P.ID, 'noteGift' + P.ID)"><i class="ti-basket"></i></a>
                                    </div>
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
const giftCatalog = {
    data() {
        return {
            products: [],
            promotions: [],
        }
    },
    methods: {
        addToCart(pid, sub, count, note) {
            const self = this;
            const formData = new FormData();
            formData.append('productId', pid);
            formData.append('variantId', T(`#${sub}`)[0].value);
            formData.append('quantity', T(`#${count}`)[0].value);
            formData.append('orderNotes', T(`#${note}`)[0].value);

            axios.post('/Order/OrderAPI/add2GiftCatalog', formData).then(result => {
                const response = result.data;
                if(!response.success){
                    T.modal({ html : response.message || '{#error_again#}' });
                } else {
                    T.notify({
                        text: '{#product_select_ok#}',
                        className: 'success',
                        stopOnFocus : true,
                        duration: 2400,
                        iconClass : 'ti-thumbs-up',
                    });
                    self.getCatalog();
                    const id = T('[name="paymentCargo"]:checked')[0].dataset.id;
                    OrderPayment.methods.getPaymentOptions(id);
                }
            }).catch(error => {
                T.modal({ html: '{#error_again#}' });
            });
        },
        remove(pid) {
            const self = this;
            axios.get('/Order/OrderAPI/removeGiftCatalog/' + pid).then(result => {
                const response = result.data;
                if(!response.success){
                    T.modal({ html : response.message || '{#error_again#}' });
                } else {
                    T.notify({
                        text: '{#product_select_no#}',
                        className: 'danger',
                        stopOnFocus : true,
                        duration: 2400,
                        iconClass : 'ti-thumbs-up',
                    });
                    self.getCatalog();
                    OrderPayment.methods.getOrderSummary();
                }
            }).catch(error => {
                T.modal({ html: '{#error_again#}' });
            });
        },
        updateQty(pid, count) {
            const self = this;
            const formData = new FormData();
            formData.append('quantity', count);

            axios.post('/Order/OrderAPI/updateGiftCatalog/' + pid, formData).then(result => {
                const response = result.data;
                if(!response.success){
                    T.modal({ html : response.message || '{#error_again#}' });
                    self.getCatalog();
                } else {
                    OrderPayment.methods.getOrderSummary();
                }
            }).catch(error => {
                T.modal({ html: '{#error_again#}' });
            });
        },
        getCatalog() {
            const self = this;
            axios.get('/srv/service/order-v5/gift-catalog').then(result => {
                self.products = result.data.products;
                self.promotions = result.data.promotions;
                setTimeout(() => { initComponents(); }, 250);
            });
        },
    },
    mounted() {
        this.getCatalog();
        window[`updateQty`] = (count, oldCount, qty) => {
            const id = qty.dataset.id;
            this.updateQty(id, count);
        }
    },
};

Vue.createApp(giftCatalog).mount('#gift-catalog');
</script>
