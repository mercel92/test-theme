<div id="popup-cart-offer" class="w-100" v-cloak>
    <div class="col-12">
        <div class="row">
            <div class="col-12 border">
                <div class="row border-bottom">
                    <div class="col-12 py-1 fw-bold">{#ask_offer#}</div>
                </div>
                <div class="row border-bottom">
                    <div class="col-12 py-1">{#cart_products#}</div>
                </div>
                <div class="row border-bottom py-1 bg-light">
                    <div class="col-6 fw-semibold">{#product_name#}</div>
                    <div class="col-2 fw-semibold text-center">{#count#}</div>
                    <div class="col-4 fw-semibold text-right">{#price#}</div>
                </div>
                <div class="row" v-for="(P, index) in data.PRODUCTS" :class="{ 'border-bottom': (index + 1) < data.PRODUCT_COUNT }">
                    <div class="col-6 py-1 d-flex">
                        <div class="w-25 d-inline-flex">
                            <div class="border image-wrapper">
                                <figure class="image-inner">
                                    <img :src="P.IMAGE.SMALL" alt="P.TITLE">
                                </figure>
                            </div>
                        </div>
                        <div class="pl-1">{{ P.TITLE }} {{ P.VARIANT_NAME }}</div>
                    </div>
                    <div class="col-2 py-1 border-left text-center">{{ P.COUNT }}</div>
                    <div class="col-4 py-1 border-left text-right">{{ format(P.PRICE_TOTAL) }} {{ P.TARGET_CURRENCY }}</div>
                </div>
            </div>
            <form id="offer-form" action="/srv/service/offer/send" method="POST" class="col-12 py-1" novalidate autocomplete="off" ref="offerSend" @submit.prevent="sendForm">
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#company_name#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <input type="text" id="offer-company" name="company" class="form-control" :value="data.CUSTOMER.COMPANY">
                        </div>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#fullname#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <input type="text" id="offer-fullname" name="fullname" class="form-control" :value="data.CUSTOMER.FIRSTNAME + ' ' + data.CUSTOMER.LASTNAME" data-validate="required">
                        </div>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#email#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <input type="email" id="offer-email" name="email" class="form-control" :value="data.CUSTOMER.EMAIL" data-validate="required,email">
                        </div>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#city#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <select id="offer-city" name="city" class="form-control" data-validate="required">
                                <option value="">{#city#}</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#town#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <select name="town" id="offer-town" class="form-control" data-validate="required">
                                <option value="">{#town#}</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#work_phone#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <input type="tel" id="offer-work_phone" name="work_phone" class="form-control" :value="data.CUSTOMER.PHONE" data-flag-masked data-validate="required">
                        </div>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#mobile_phone#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <input type="tel" id="mobile_phone" name="mobile_phone" class="form-control" :value="data.CUSTOMER.GSM" data-flag-masked data-validate="required">
                        </div>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#fax#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <input type="tel" id="offer-fax" name="fax" class="form-control">
                        </div>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-4 fw-bold">{#note#}</div>
                    <div class="col-1 fw-bold text-center">:</div>
                    <div class="col-7">
                        <div class="popover-wrapper position-relative">
                            <textarea id="offer-notes" name="notes" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <button type="submit" id="offer-send" class="w-100 btn btn-success">{#send#}</button>
                    </div>
                </div>
            </form>
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

    const PopupCartOffer = {
        data() {
            return {
                data: DATA
            }
        },
        methods: {
            format(p) {
                return T.format(p);
            },
            sendForm() {
                const self = this;
                const form = self.$refs.offerSend;
                const formData = new FormData(form);

                if (!T.checkValidity(form)) return;
                axios.post(form.action, formData).then(response => {
                    const res = response.data;
                    if(res.status === false) {
                        popoverAlert.show(
                            form.querySelector(`input[name="${res.key}"]`), 
                            res.statusText, 
                            2000, 
                            `btn btn-danger text-left`
                        );
                    } else {
                        T.notify({
                            text: res.statusText,
                            className: 'btn btn-success',
                            duration: 2000
                        });
                        T('.t-modal-close').trigger('click');
                    }
                });
            }
        },
        mounted() {
            console.log(this.data);
            setTimeout(() => { 
                initComponents(); 
                
                regionLoader({
                    country: {
                        selector: ``, value: 'TR'
                    },
                    city: {
                        selector: `#offer-city`, value: this.data.CUSTOMER.CITY || T('#offer-city')[0].value
                    },
                    town: {
                        selector: `#offer-town`, value: this.data.CUSTOMER.TOWN || T('#offer-town')[0].value
                    },
                    countryLimit : false
                });

            }, 250);
        }
    };

    Vue.createApp(PopupCartOffer).mount('#popup-cart-offer');
</script>