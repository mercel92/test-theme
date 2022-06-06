<div id="my-point-order-detail" class="w-100" v-cloak>
    <div class="col-12">
        <div class="row" v-if="!LOADING">
            <div class="w-100 block-title mb-1 p-0">
                {#order_detail#}
            </div>
            <div class="w-100 border border-light border-round mb-1 point-order-detail-table">
                <div class="col-12 bg-light fw-bold py-1 border-bottom border-light point-order-detail-table-title">
                    {#products#}
                </div>
                <div class="w-100 d-flex flex-wrap align-items-center" v-bind:class="index === data.ORDER.PRODUCT_LIST.length - 1 ? '' : 'border-bottom border-light'" v-for="(P, index) in data.ORDER.PRODUCT_LIST">
                    <div class="col-12 col-sm">
                        <div class="row align-items-center">
                            <div class="col-2 col-sm-4 py-1">
                                <div class="image-wrapper">
                                    <span class="image-inner">
                                        <img :src="P.IMAGE" :alt="P.TITLE">
                                    </span>
                                </div>
                            </div>
                            <div class="col-10 col-sm-8 py-1">
                                <a :href="'/' + P.URL" class="text-body fw-medium">{{ P.TITLE }} 
                                <span v-if="P.SUBTITLE">( {{P.SUBTITLE}} )</span></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm">
                        <div class="row align-items-center">
                            <div class="col-6 col-sm-4 py-1">
                                <div>{{ P.UNIT }}</div>
                                <div><strong>{{ P.COUNT }}</strong></div>
                            </div>
                            <div class="col-6 col-sm-8 py-1">
                                <div>{#vat_price#}</div>
                                <div><strong>{{P.PRICE_SELL}} {{P.CURRENCY}}</strong></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm">
                        <div class="row align-items-center">
                            <div class="col-6 py-1">
                                <div>{#supply_status#}</div>
                                <div><strong>{{P.SUPPLY_STATUS_CODE}}</strong></div>
                            </div>
                            <div class="col-6 py-1">
                                <div>{#supply_note#}</div>
                                <div><strong>{{P.SUPPLY_NOTE}}</strong></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm" v-if="P.PERSONALIZATION_FORM.length > 0">
                        <div v-for="F in P.PERSONALIZATION_FORM">
                            {{F.TITLE}} : <span class="fw-bold" v-html="F.VALUE"></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="w-100 border border-light border-round mb-1 point-order-detail-table">
                <div class="col-12 bg-light fw-bold py-1 border-bottom border-light point-order-detail-table-title">
                    {#amounts#}
                </div>
                <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1" v-if="data.ORDER.KARGOFIYAT">
                    <div class="col-6 col-md">
                        {#cargo_price#}
                    </div>
                    <div class="col-6 col-md">
                        <strong>{{data.ORDER.KARGOFIYAT}} {{data.ORDER.CURRENCY}}</strong>
                    </div>
                </div>
                <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1" v-if="data.ORDER.SERVISFIYAT">
                    <div class="col-6 col-md">
                        {#service_price#}
                    </div>
                    <div class="col-6 col-md">
                        <strong>{{data.ORDER.SERVISFIYAT}} {{data.ORDER.CURRENCY}}</strong>
                    </div>
                </div>
                <div class="w-100 d-flex flex-wrap align-items-center py-1" v-if="data.ORDER.TOTAL_PRICE">
                    <div class="col-6 col-md">
                        {#general_total#}
                    </div>
                    <div class="col-6 col-md">
                        <strong>{{data.ORDER.TOTAL_PRICE}} {{data.ORDER.CURRENCY}}</strong>
                    </div>
                </div>
            </div>

            <div class="col-12 p-0">
                <div class="row">
                    <div class="col-12 col-md-6">
                        <div class="w-100 border border-light border-round mb-1 point-order-detail-table">
                            <div class="col-12 bg-light fw-bold py-1 border-bottom border-light point-order-detail-table-title">
                                {#invoice_adress#}
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#company_name#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.COMPANY_NAME}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#tax_office#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.TAX_OFFICE}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#tax_number#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.TAX_NUMBER}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#country#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.COUNTRY}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#adress#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.ADDRESS}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#city#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.CITY}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#town#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.TOWN}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#district#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.DISTRICT}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#zip_code#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.ZIP_CODE}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#mobile_phone#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.MOBILE_PHONE}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#home_phone#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.HOME_PHONE}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center py-1">
                                <div class="col-6 col-md">{#other_phone#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.INVOICE.OTHER_PHONE}}</strong>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6">
                        <div class="w-100 border border-light border-round mb-1 point-order-detail-table">
                            <div class="col-12 bg-light fw-bold py-1 border-bottom border-light point-order-detail-table-title">
                                {#delivery_adress#}
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#fullname#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.FIRST_NAME}} {{data.ORDER.ADDRESS.DELIVERY.LAST_NAME}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#country#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.COUNTRY}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#adress#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.ADDRESS}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#city#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.CITY}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#town#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.TOWN}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#district#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.DISTRICT}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#zip_code#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.ZIP_CODE}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#mobile_phone#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.MOBILE_PHONE}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center border-bottom border-light py-1">
                                <div class="col-6 col-md">{#home_phone#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.HOME_PHONE}}</strong>
                                </div>
                            </div>
                            <div class="w-100 d-flex flex-wrap align-items-center py-1">
                                <div class="col-6 col-md">{#other_phone#}</div>
                                <div class="col-6 col-md">
                                    <strong>{{data.ORDER.ADDRESS.DELIVERY.OTHER_PHONE}}</strong>
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
        DATA = {};
    }

    const PointOrderDetail = {
        data() {
            return {
                data: DATA,
                LOADING: true
            }
        },
        mounted() {
            this.LOADING = false;
        }
    };

    Vue.createApp(PointOrderDetail).mount('#my-point-order-detail');
</script>