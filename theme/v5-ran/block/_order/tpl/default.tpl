<div id="order-steps" class="w-100 d-flex flex-wrap mb-2 position-relative" v-cloak>
    <div class="col-12" :class="$route.path == '/approve' ? '' : 'col-md-9'">
        <nav id="order-nav" class="w-100 mb-2" v-if="$route.path != '/approve'">
            <ul class="row">
                <li class="col-6">
                    <router-link to="/" class="d-flex align-items-center border" :class="{'active' : $route.params.id || $route.path == '/address'}">
                        <span class="border">1</span>{#step_address#}
                    </router-link>
                </li>
                <li class="col-6">
                    <router-link to="payment" disabled class="d-flex align-items-center border">
                        <span class="border">2</span>{#step_payment#}
                    </router-link>
                </li>
            </ul>
        </nav>
        <div class="w-100 content" :data-route="$route.path" :data-next="nextPaymentStep">
            <router-view></router-view>
        </div>
    </div>
    <div class="col-12 col-md-3" v-if="!loading && $route.path != '/approve'">
        <div class="w-100 order-rightbar-sticky position-desktop-sticky">
            <div id="order-products" class="w-100 border border-round mb-1">
                <div class="p-1 payment-list-title d-flex align-items-center justify-content-between accordion-title active" data-toggle="accordion">
                    {#order_summary#}
                    <span class="icon-wrapper">
                        <i class="ti-arrow-down"></i>
                        <i class="ti-arrow-up"></i>
                    </span>
                </div>
                <div class="w-100 border-top accordion-body">
                    <ul class="w-100 list-style-none product-list">
                        <li class="row mx-0 py-1" v-for="(p, i) in summaryData.PRODUCTS" :class="{ 'border-top': i > 0 }">
                            <div class="col-4">
                                <div class="w-100 image-wrapper">
                                    <span class="image-inner">
                                        <img :src="p.IMAGE" :alt="p.NAME">
                                    </span>
                                </div>
                            </div>
                            <div class="col-8 pl-0 text-body text-dark">
                                <strong class="brand-name" v-if="p.BRAND != ''">{{ p.BRAND }}</strong>
                                <div class="product-name">{{ p.NAME }}</div>
                                <div class="subproduct-and-count text-gray">
                                    <span v-if="p.SUBPRODUCTNAME != ''">{{ p.SUBPRODUCTNAME }} x </span>
                                    <span>{{ p.COUNT }} {{ p.QUANTITYTYPE }}</span>
                                </div>
                                <div class="text-primary price"><strong>{{ format(p.TOTALSALEPRICE) }}</strong> {{ summaryData.CURRENCY }}</div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="order-note" class="w-100 border border-round mb-1 d-none">
                <div class="p-1 fw-bold d-flex align-items-center justify-content-between accordion-title" data-toggle="accordion">
                    {#shopping_note#}
                    <span class="icon-wrapper">
                        <i class="ti-arrow-down"></i>
                        <i class="ti-arrow-up"></i>
                    </span>
                </div>
                <div class="p-1 border-top accordion-body">govde</div>
            </div>
            <div id="order-gift-code" class="w-100 border border-round mb-1 d-none">
                <div class="p-1 fw-bold d-flex align-items-center justify-content-between accordion-title" data-toggle="accordion">
                    {#add_coupon#}
                    <span class="icon-wrapper">
                        <i class="ti-arrow-down"></i>
                        <i class="ti-arrow-up"></i>
                    </span>
                </div>
                <div class="p-1 border-top accordion-body">govde</div>
            </div>
            <div id="erp-points" class="w-100 border border-round mb-1" v-if="summaryData.ERPPOINT && summaryData.ERPPOINT.ACTIVE == 1">
                <div class="p-1 fw-bold d-flex align-items-center justify-content-between accordion-title" data-toggle="accordion">
                    {#use_point#}
                    <span class="icon-wrapper">
                        <i class="ti-arrow-down"></i>
                        <i class="ti-arrow-up"></i>
                    </span>
                </div>
                <div class="p-1 border-top accordion-body">
                    <div class="w-100" v-if="summaryData.ERPPOINT.ACTIVELIMIT > summaryData.ERPPOINT.CARTTOTAL && summaryData.ERPPOINT.POINT == 0">
                        {{ summaryData.ERPPOINT.ACTIVEMSG }}
                    </div>
                    <div class="w-100" v-if="summaryData.ERPPOINT.ACTIVELIMIT <= summaryData.ERPPOINT.CARTTOTAL || summaryData.ERPPOINT.POINT > 0">
                        <div class="mb-1" v-if="summaryData.ERPPOINT.TOTALPOINT == 0">
                            <button type="button" class="btn btn-gray w-100 text-uppercase" @click="erpPointReq()">{#inquire#}</button>
                        </div>
                        <div class="w-100" v-if="summaryData.ERPPOINT.TOTALPOINT > 0">
                            <div class="text-body mb-8">{#total_point#} : {{summaryData.ERPPOINT.TOTALPOINT}} ({{format(summaryData.ERPPOINT.TOTALAMOUNT)}} {{ summaryData.CURRENCY }})</div>
                            <div class="text-primary" v-if="summaryData.ERPPOINT.POINT > 0">{#used_point#} : {{summaryData.ERPPOINT.POINT}} ({{format(summaryData.ERPPOINT.AMOUNT)}} {{ summaryData.CURRENCY }})</div>
                            <div class="w-100 mt-1">
                                <label for="erp-point-control" class="w-100 fw-regular">
                                    {#used_point_amount#}
                                </label>
                                <div class="w-100 d-flex align-items-center mb-1">
                                    <div class="popover-wrapper">
                                        <input type="number" class="form-control no-arrows" autocomplete="off" id="erp-point-control"
                                        :value="summaryData.ERPPOINT.POINT > 0 ? summaryData.ERPPOINT.AMOUNT : ''">
                                    </div>
                                    <span class="ml-1">{{ summaryData.CURRENCY }}</span>
                                </div>
                                <button type="button" class="btn btn-primary w-100 text-uppercase" @click="erpPointSet('erp-point-control')">{#use#}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="order-points" class="w-100 border border-round mb-1" v-if="summaryData.CUSTOMERPOINT && summaryData.CUSTOMERPOINT.ACTIVE == 1 && summaryData.CUSTOMERPOINT.TOTALPOINT > 0">
                <div class="p-1 fw-bold d-flex align-items-center justify-content-between accordion-title" data-toggle="accordion">
                {#use_point#}
                    <span class="icon-wrapper">
                        <i class="ti-arrow-down"></i>
                        <i class="ti-arrow-up"></i>
                    </span>
                </div>
                <div class="p-1 border-top accordion-body">
                    <div class="w-100" v-if="summaryData.CUSTOMERPOINT.ACTIVELIMIT > summaryData.CUSTOMERPOINT.CARTTOTAL && summaryData.CUSTOMERPOINT.POINT == 0">
                        {{ summaryData.CUSTOMERPOINT.ACTIVEMSG }}
                    </div>
                    <div class="w-100" v-if="summaryData.CUSTOMERPOINT.ACTIVELIMIT <= summaryData.CUSTOMERPOINT.CARTTOTAL || summaryData.CUSTOMERPOINT.POINT > 0">
                        <div class="text-body mb-8">Toplam Puanınız : {{summaryData.CUSTOMERPOINT.TOTALPOINT}} ({{format(summaryData.CUSTOMERPOINT.TOTALAMOUNT)}} {{ summaryData.CURRENCY }})</div>
                        <div class="text-primary" v-if="summaryData.CUSTOMERPOINT.USEDPOINT > 0">{#used_point#} : {{summaryData.CUSTOMERPOINT.USEDPOINT}} ({{format(summaryData.CUSTOMERPOINT.USEDAMOUNT)}} {{ summaryData.CURRENCY }})</div>
                        <div class="w-100 mt-1">
                            <label for="customer-point-control" class="w-100 fw-regular">
                                {#used_point_amount#}
                            </label>
                            <div class="w-100 d-flex align-items-center mb-1">
                                <div class="popover-wrapper">
                                    <input type="number" class="form-control no-arrows" autocomplete="off" id="customer-point-control"
                                    :value="summaryData.CUSTOMERPOINT.POINT > 0 ? summaryData.CUSTOMERPOINT.AMOUNT : ''">
                                </div>
                                <span class="ml-1">{{ summaryData.CURRENCY }}</span>
                            </div>
                            <button type="button" class="btn btn-primary w-100 text-uppercase" @click="erpPointSet('customer-point-control', 'site')">{#use#}</button>
                            <div class="w-100 mt-1" v-if="summaryData.CUSTOMERPOINT.TOGIFTPRODUCT == 1">
                                <div class="mb-1">{#to_gift_product#}</div>
                                <a class="btn btn-gray w-100 text-uppercase popupwin" href="/srv/service/content-v5/sub-folder/91/1119/point-gift-catalog" data-width="1150">Seç</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="order-summary" class="w-100 p-1 border border-round text-gray mb-1" v-if="summaryData && summaryData.AMOUNTS">
                <div class="row">
                    <div class="col-6">{#cart_total#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.AMOUNTS.PRODUCTS_TOTAL) }} {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row" v-if="summaryData.AMOUNTS.GIFTPACKAGES_TOTAL > 0">
                    <div class="col-6">{#gift_packages_total#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.AMOUNTS.GIFTPACKAGES_TOTAL) }} {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row" v-if="summaryData.AMOUNTS.DISCOUNT_TOTAL > 0">
                    <div class="col-6">{#discount_total#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.AMOUNTS.DISCOUNT_TOTAL) }} {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row" v-if="summaryData.AMOUNTS.HOPI_COIN > 0">
                    <div class="col-6">{#hopi_coin#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.AMOUNTS.HOPI_COIN) }} {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row" v-if="summaryData.ERPPOINT != null && summaryData.ERPPOINT.ACTIVE == 1 && summaryData.ERPPOINT.AMOUNT > 0">
                    <div class="col-6">{#point#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.ERPPOINT.AMOUNT) }} {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row" v-if="summaryData.CUSTOMERPOINT != null && summaryData.CUSTOMERPOINT.ACTIVE == 1 && summaryData.CUSTOMERPOINT.AMOUNT > 0">
                    <div class="col-6">{#point#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.CUSTOMERPOINT.AMOUNT) }} {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row" v-if="summaryData.AMOUNTS.SERVICE_TOTAL > 0">
                    <div class="col-6">{#service_total#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.AMOUNTS.SERVICE_TOTAL) }} {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row" v-if="summaryData.PERMISSIONS.CARGOPAYTYPE != 1">
                    <div class="col-6">{#cargo_total#}</div>
                    <div class="col-6 text-right"><span id="priceCargo">{{ format(summaryData.AMOUNTS.CARGO_TOTAL) }}</span> {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row" v-if="summaryData.AMOUNTS.DUTY_SERVICE_TOTAL > 0">
                    <div class="col-6" title="{#duty_service_total_title#}.">{#duty_service_total#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.AMOUNTS.DUTY_SERVICE_TOTAL) }} {{ summaryData.CURRENCY }}</div>
                </div>
                <div class="row fw-bold text-primary">
                    <div class="col-6">{#general_total#}</div>
                    <div class="col-6 text-right">{{ format(summaryData.AMOUNTS.TOTAL) }} {{ summaryData.CURRENCY }}</div>
                </div>
            </div>
            <div id="order-agreements" class="w-100 mb-1" v-if="$route.path == '/payment' && payAgreements == false">
                <div class="order-agreements-item mb-1 border"
                v-if="summaryData.PERMISSIONS.ISACTIVEPRELIMINARYINFORMATIONFORM == 1 && summaryData.PERMISSIONS.ISACTIVEDISTANCEAGREEMENT == 0 && summaryData.PERMISSIONS.ISACTIVECLARIFICATIONTEX == 0">
                    <input type="checkbox" name="confirmPreliminaryInformationForm" id="confirmPreliminaryInformationForm" class="form-control">
                    <label for="confirmPreliminaryInformationForm" class="m-0 d-flex align-items-center fw-regular p-1">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        <div><a href="/srv/service/order-v4/get-preliminary-information-form" data-width="800" class="popupwin text-primary">{#preliminary_information#}</a> {#accept#}.</div>
                    </label>
                </div>
                <div class="order-agreements-item mb-1 border"
                v-else-if="summaryData.PERMISSIONS.ISACTIVEPRELIMINARYINFORMATIONFORM == 0 && summaryData.PERMISSIONS.ISACTIVEDISTANCEAGREEMENT == 1 && summaryData.PERMISSIONS.ISACTIVECLARIFICATIONTEX == 0">
                    <input type="checkbox" name="confirmDistanceSellingAgreement" id="confirmDistanceSellingAgreement" class="form-control">
                    <label for="confirmDistanceSellingAgreement" class="m-0 d-flex align-items-center fw-regular p-1">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        <div><a href="/srv/service/order-v4/get-distance-agreement" data-width="800" class="popupwin text-primary">{#distance_agreement#}</a> {#accept#}.</div>
                    </label>
                </div>
                <div class="order-agreements-item mb-1 border"
                v-else-if="summaryData.PERMISSIONS.ISACTIVEPRELIMINARYINFORMATIONFORM == 0 && summaryData.PERMISSIONS.ISACTIVEDISTANCEAGREEMENT == 0 && summaryData.PERMISSIONS.ISACTIVECLARIFICATIONTEX == 1">
                    <input type="checkbox" name="confirmClarificationText" id="confirmClarificationText" class="form-control">
                    <label for="confirmClarificationText" class="m-0 d-flex align-items-center fw-regular p-1">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        <div><a href="/srv/service/order-v4/get-clarification-text" data-width="800" class="popupwin text-primary">{#clarification_text#}</a> {#accept#}.</div>
                    </label>
                </div>
                <div class="order-agreements-item mb-1 border" v-else>
                    <input type="checkbox" name="confirmDistanceSellingAgreement" id="confirmDistanceSellingAgreement" class="form-control">
                    <label for="confirmDistanceSellingAgreement" class="m-0 d-flex align-items-center fw-regular p-1">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        <div>
                            <span v-if="summaryData.PERMISSIONS.ISACTIVEPRELIMINARYINFORMATIONFORM == 1">
                                <a href="/srv/service/order-v4/get-preliminary-information-form" data-width="800" class="popupwin text-primary">{#preliminary_information#}</a>
                            <span>
                            <span v-if="summaryData.PERMISSIONS.ISACTIVEDISTANCEAGREEMENT == 1">
                                {#and#} <a href="/srv/service/order-v4/get-distance-agreement" data-width="800" class="popupwin text-primary">{#distance_agreement#}</a>
                            </span>
                            <span v-if="summaryData.PERMISSIONS.ISACTIVECLARIFICATIONTEX == 1">
                                {#and#} <a href="/srv/service/order-v4/get-clarification-text" data-width="800" class="popupwin text-primary">{#clarification_text#}</a>
                            </span>
                            {#accept#}.
                        </div>
                    </label>
                </div>
            </div>
            <div class="w-100 payment-button-container bg-white">
                <div class="row align-items-center">
                    <div class="col-5 d-block d-md-none">
                        <div class="w-100 d-flex align-items-center order-price-btn" @click="goOrderSummary('#order-summary')">
                            <div>
                                <div class="small-text">{#general_total#}</div>
                                <div class="fw-bold">{{ format(summaryData.AMOUNTS.TOTAL) }} {{ summaryData.CURRENCY }}</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-7 col-md-12">
                        <button type="button" v-if="$route.path == '/' && addresses.DELIVERY_FROM_STORE == 0" class="btn btn-primary w-100 text-uppercase order-next-btn" @click="nextStep">
                            <span>{#to_payment_step#}</span>
                            <i class="ti-arrow-right ml-1"></i>
                        </button>
                        <button type="button" v-if="$route.path == '/' && addresses.DELIVERY_FROM_STORE == 1" class="btn btn-primary w-100 text-uppercase order-next-btn" @click="storeNextStep">
                            <span>{#to_payment_step#}</span>
                            <i class="ti-arrow-right ml-1"></i>
                        </button>
                        <button type="button" v-if="$route.path == '/payment' && payAgreements == false" class="btn btn-primary w-100 text-uppercase order-next-btn" @click="nextStep">
                            <span>{#complete_order#}</span>
                            <i class="ti-arrow-right ml-1"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<template id="order-address">
    <div id="order-address" v-if="addresses.DELIVERY_FROM_STORE == 0">
        <div class="d-flex align-items-center justify-content-between mb-2">
            <div class="step-title"><i class="ti-location"></i> {#address_selection#}</div>
            <router-link to="/address" class="btn btn-gray text-uppercase">{#new_address#} <i class="ti-plus ml-1"></i></router-link>
        </div>
        <div class="w-100 order-address-list">
            <div class="row">
                <div class="col-12 col-md-6 mb-2 address-item" v-for="(address, index) in addresses.ADDRESS_LIST">
                    <div class="w-100 h-100 border address-box">
                        <div class="d-flex align-items-center justify-content-between pt-1 border-bottom address-top">
                            <div class="col pb-1">
                                <div class="text-gray address-title w-100" :title="address.TITLE + ' - ' + address.FULLNAME">
                                    {{ address.TITLE }} - {{ address.FULLNAME }}
                                </div>
                            </div>
                            <div class="col-auto pb-1">
                                <div class="row address-btns">
                                    <div class="col-auto">
                                        <router-link :to="'/address/' + address.ID" class="btn text-gray text-underline">
                                            <i class="ti-pencil"></i> {#edit#}
                                        </router-link>
                                    </div>
                                    <div class="col-auto">
                                        <button type="button" class="btn text-gray text-underline"
                                        :data-id="address.ID"
                                        data-toggle="popconfirm"
                                        data-title="{#want_to_delete#}"
                                        data-confirm="{#yes_text#}"
                                        data-cancel="{#no_text#}"
                                        data-icon="ti-trash-o text-primary"
                                        data-loading="true"
                                        data-callback="deleteAddress">
                                            <i class="ti-trash-o"></i> {#delete#}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <address class="p-1 border-bottom text-gray">
                            <p class="mb-1">
                                {{ address.ADDRESS }}<br>
                                {{ address.DISTRICT }} / {{ address.TOWN }} / {{ address.CITY }} / {{ address.COUNTRY }} / {{ address.POST_CODE }}
                            </p>
                            {{ address.MOBILE_PHONE }}
                        </address>
                        <div class="col-12 pt-1 order-address-selection">
                            <div class="row">
                                <div class="col-auto pb-1" v-if="address.STATUSDELIVERY == 1">
                                    <input type="radio" name="delivery_address" class="form-control" 
                                        :value="address.ID" :id="'delivery_address_' + address.ID" :checked="address.ID == addresses.DELIVERY_ADDRESS_ID"
                                        @change="setOrderAddress(address.ID, 'delivery')">
                                    <label :for="'delivery_address_' + address.ID" class="mb-0 ease fw-regular text-gray d-flex align-items-center">
                                        <span class="input-checkbox"><i class="ti-check"></i></span>
                                        {#use_for_delivery#}
                                    </label>
                                </div>
                                <div class="col-auto pb-1">
                                    <input type="radio" name="invoice_address" class="form-control" 
                                        :value="address.ID" :id="'invoice_address_' + address.ID" :checked="address.ID == addresses.INVOICE_ADDRESS_ID"
                                        @change="setOrderAddress(address.ID, 'invoice')">
                                    <label :for="'invoice_address_' + address.ID" class="mb-0 ease fw-regular text-gray d-flex align-items-center">
                                        <span class="input-checkbox"><i class="ti-check"></i></span>
                                        {#use_for_invoice#}
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <router-link to="/address" class="col-12 col-md-6 mb-2 address-item">
                    <div class="w-100 h-100 border address-box address-box-add text-body p-2 text-center">
                        {#add_new_address#}<br>
                        <i class="d-block ti-plus text-light mt-2"></i>
                    </div>
                </router-link>
            </div>
        </div>
    </div>
    <div id="order-address-tab" v-if="addresses.DELIVERY_FROM_STORE == 1">
        <div class="row address-tab mb-1">
            <div class="col-6">
                <button class="btn w-100 text-center" :class="storeTab == 0 ? 'btn-primary' : 'btn-light'" @click="storeTab = 0">
                    {#choose_address_send#}
                </button>
            </div>
            <div class="col-6 active">
                <button class="btn w-100 text-center" :class="storeTab == 1 ? 'btn-primary' : 'btn-light'" @click="storeTab = 1">
                    {#choose_delivery_send#}
                </button>
            </div>
        </div>
        <div class="address-tab-content">
            <div id="order-address-list" class="w-100" :class="storeTab == 0 ? 'd-block' : 'd-none'">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <div class="step-title"><i class="ti-location"></i> {#address_selection#}</div>
                    <router-link to="/address" class="btn btn-gray text-uppercase">{#new_address#} <i class="ti-plus ml-1"></i></router-link>
                </div>
                <div class="w-100 order-address-list">
                    <div class="row">
                        <div class="col-12 col-md-6 mb-2 address-item" v-for="(address, index) in addresses.ADDRESS_LIST">
                            <div class="w-100 h-100 border address-box">
                                <div class="d-flex align-items-center justify-content-between pt-1 border-bottom address-top">
                                    <div class="col pb-1">
                                        <div class="text-gray address-title w-100" :title="address.TITLE + ' - ' + address.FULLNAME">
                                            {{ address.TITLE }} - {{ address.FULLNAME }}
                                        </div>
                                    </div>
                                    <div class="col-auto pb-1">
                                        <div class="row address-btns">
                                            <div class="col-auto">
                                                <router-link :to="'/address/' + address.ID" class="btn text-gray text-underline">
                                                    <i class="ti-pencil"></i> {#edit#}
                                                </router-link>
                                            </div>
                                            <div class="col-auto">
                                                <button type="button" class="btn text-gray text-underline"
                                                :data-id="address.ID"
                                                data-toggle="popconfirm"
                                                data-title="{#want_to_delete#}"
                                                data-confirm="{#yes_text#}"
                                                data-cancel="{#no_text#}"
                                                data-icon="ti-trash-o text-primary"
                                                data-loading="true"
                                                data-callback="deleteAddress">
                                                    <i class="ti-trash-o"></i> {#delete#}
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <address class="p-1 border-bottom text-gray">
                                    <p class="mb-1">
                                        {{ address.ADDRESS }}<br>
                                        {{ address.DISTRICT }} / {{ address.TOWN }} / {{ address.CITY }} / {{ address.COUNTRY }} / {{ address.POST_CODE }}
                                    </p>
                                    {{ address.MOBILE_PHONE }}
                                </address>
                                <div class="col-12 pt-1 order-address-selection">
                                    <div class="row">
                                        <div class="col-auto pb-1" v-if="address.STATUSDELIVERY == 1">
                                            <input type="radio" name="delivery_address" class="form-control" 
                                                :value="address.ID" :id="'delivery_address_' + address.ID" :checked="address.ID == addresses.DELIVERY_ADDRESS_ID"
                                                @change="setOrderAddress(address.ID, 'delivery')">
                                            <label :for="'delivery_address_' + address.ID" class="mb-0 ease fw-regular text-gray d-flex align-items-center">
                                                <span class="input-checkbox"><i class="ti-check"></i></span>
                                                {#use_for_delivery#}
                                            </label>
                                        </div>
                                        <div class="col-auto pb-1">
                                            <input type="radio" name="invoice_address" class="form-control" 
                                                :value="address.ID" :id="'invoice_address_' + address.ID" :checked="address.ID == addresses.INVOICE_ADDRESS_ID"
                                                @change="setOrderAddress(address.ID, 'invoice')">
                                            <label :for="'invoice_address_' + address.ID" class="mb-0 ease fw-regular text-gray d-flex align-items-center">
                                                <span class="input-checkbox"><i class="ti-check"></i></span>
                                                {#use_for_invoice#}
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <router-link to="/address" class="col-12 col-md-6 mb-2 address-item">
                            <div class="w-100 h-100 border address-box address-box-add text-body p-2 text-center">
                                {#add_new_address#}<br>
                                <i class="d-block ti-plus text-light mt-2"></i>
                            </div>
                        </router-link>
                    </div>
                </div>
            </div>
            <div id="order-address-store" class="w-100" :class="storeTab == 1 ? 'd-block' : 'd-none'">
                <div class="row">
                    <div class="col-12 mb-1">
                        <div class="step-title"><i class="ti-location"></i> {#selection_delivery_point#}</div>
                    </div>
                    <div class="col-12 order-address-store">
                        <div class="row">
                            <div class="col-12 col-sm-6 address-store-filter">
                                <div class="w-100 mb-1">
                                    <select class="form-control form-control-md" @change="storeSelect($event, 'country')">
                                        <option value="">{#country#}</option>
                                        <option v-for="country in storeAddressList.countries" :value="country.code" :selected="storeAddressList.exportCountry == country.code">{{ country.name }}</option>
                                    </select>
                                </div>
                                <div class="w-100 mb-1">
                                    <select class="form-control form-control-md" @change="storeSelect($event, 'city')">
                                        <option value="">{#city#}</option>
                                        <option v-for="city in storeAddressList.cities" :value="city.code">{{ city.name }}</option>
                                    </select>
                                </div>
                                <div class="w-100 mb-1">
                                    <select class="form-control form-control-md" @change="storeSelect($event, 'town')">
                                        <option value="">{#town#}</option>
                                        <option v-for="town in storeAddressList.towns" :value="town.code">{{ town.name }}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="border address-box mb-1">
                                    <div class="p-1 border-bottom text-gray address-title">{#recipient_information#}</div>
                                    <div class="p-1">
                                        <div class="w-100 popover-wrapper mb-1">
                                            <input type="text" id="store-delivery-name" class="form-control form-control-md" placeholder="{#recipient_fullname#}" autocorrect="off" autocapitalize="off">
                                        </div>
                                        <div class="w-100 popover-wrapper">
                                            <input type="tel" id="store-delivery-phone" class="form-control form-control-md" data-flag-masked>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 col-md-6 mb-1 address-item" v-for="store in storeAddressList.stories">
                                <div class="border border-round px-1 w-100 h-100 address-box" :class="{'border-primary' : store.id == storeAddressList.storeId}">
                                    <div class="row align-items-center justify-content-between border-bottom p-1">
                                        <div class="address-title text-gray" :title="store.Ad + ' - ' + store.IlAdi">{{ store.Ad }} - {{ store.IlAdi }}</div>
                                    </div>
                                    <div class="row">
                                        <div class="py-1" :class="store.Foto1 == '' ? 'col-12' : 'col-8'">
                                            <address class="w-100 text-gray">
                                                <p class="m-0 p-0" v-html="store.Adres"></p>
                                                <p>{{ store.Semt }} / {{ store.IlceAdi }} / {{ store.IlAdi }} / {{ store.UlkeAdi }}</p>
                                                <p>{{ store.Telefon }}</p>
                                                {{ store.Mail }}
                                            </address>
                                        </div>
                                        <div class="col-4 py-1" v-if="store.Foto1 != ''">
                                            <div class="d-flex align-items-center">
                                                <img class="border-round" :src="'/Data/Magazalar/' + store.Foto1">
                                            </div>
                                        </div>
                                        <div class="col-12 pb-1 order-address-selection">
                                            <a target="_blank" :href="'/' + store.seo_link" class="btn btn-gray mr-1">{#show_map#}</a>
                                            <input type="radio" name="store-btn" :id="'store-btn' + store.id" class="form-control" :checked="storeAddressList.storeId == store.id"
                                            @change="storeAddressList.storeId = store.id">
                                            <label :for="'store-btn' + store.id" class="btn btn-outline-light text-gray mb-0 ease">
                                                <span class="input-checkbox"><i class="ti-check"></i></span>
                                                {#select_here#}
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="w-100 popover-wrapper position-relative">
                    <input type="checkbox" id="store-invoice-address" class="form-control">
                    <label for="store-invoice-address" class="p-0 mb-2 d-flex align-items-center" data-toggle="accordion">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        {#invoice_address_check#}
                    </label>
                    <div class="w-100 accordion-body">
                        <div class="d-flex align-items-center justify-content-between">
                            <div class="step-title"><i class="ti-location"></i> {#address_selection#}</div>
                            <router-link to="/address" class="btn btn-gray">{#new_address#} <i class="ti-plus ml-1"></i></router-link>
                        </div>
                        <div class="col-12 px-0 order-address-list">
                            <div class="row mt-1" v-if="addresses.ADDRESS_LIST.length > 0">
                                <div class="col-12 col-md-6 mb-1 address-item" v-for="(address, index) in addresses.ADDRESS_LIST">
                                    <div class="w-100 h-100 border address-box">
                                        <div class="d-flex align-items-center justify-content-between pt-1 border-bottom address-top">
                                            <div class="col pb-1">
                                                <div class="text-gray address-title w-100" :title="address.TITLE + ' - ' + address.FULLNAME">
                                                    {{ address.TITLE }} - {{ address.FULLNAME }}
                                                </div>
                                            </div>
                                            <div class="col-auto pb-1">
                                                <div class="row address-btns">
                                                    <div class="col-auto">
                                                        <router-link :to="'/address/' + address.ID" class="btn text-gray text-underline">
                                                            <i class="ti-pencil"></i> {#edit#}
                                                        </router-link>
                                                    </div>
                                                    <div class="col-auto">
                                                        <button type="button" class="btn text-gray text-underline"
                                                        :data-id="address.ID"
                                                        data-toggle="popconfirm"
                                                        data-title="{#want_to_delete#}"
                                                        data-confirm="{#yes_text#}"
                                                        data-cancel="{#no_text#}"
                                                        data-icon="ti-trash-o text-primary"
                                                        data-loading="true"
                                                        data-callback="deleteAddress">
                                                            <i class="ti-trash-o"></i> {#delete#}
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <address class="p-1 border-bottom text-gray">
                                            <p class="mb-1">
                                                {{ address.ADDRESS }}<br>
                                                {{ address.DISTRICT }} / {{ address.TOWN }} / {{ address.CITY }} / {{ address.COUNTRY }} / {{ address.POST_CODE }}
                                            </p>
                                            {{ address.MOBILE_PHONE }}
                                        </address>
                                        <div class="col-12 pt-1 order-address-selection">
                                            <div class="row">
                                                <div class="col-auto pb-1">
                                                    <input type="radio" name="x-invoice_address" class="form-control" 
                                                        :value="address.ID" :id="'x-invoice_address_' + address.ID" :checked="address.ID == addresses.INVOICE_ADDRESS_ID"
                                                        @change="setOrderAddress(address.ID, 'invoice')">
                                                    <label :for="'x-invoice_address_' + address.ID" class="mb-0 ease fw-regular text-gray d-flex align-items-center">
                                                        <span class="input-checkbox"><i class="ti-check"></i></span>
                                                        {#my_invoice_send_address#}
                                                    </label>
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
        </div>
    </div>
</template>

<template id="order-address-detail">
    <div class="w-100" v-cloak v-if="loading === false">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="d-flex align-items-center justify-content-between mb-1">
                    <div class="step-title"><i class="ti-location"></i> {{ $route.params.id ? '{#edit_address#}' : '{#add_new_address#}' }}</div>
                    <button type="button" class="btn btn-gray" v-if="addresses.ADDRESS_LIST && addresses.ADDRESS_LIST.length > 0" @click="$router.push('/')"><i class="ti-arrow-left mr-1"></i> {#turn_back#}</button>
                </div>
                <div class="d-flex align-items-center fw-bold mb-1 p-1 bg-light border-round" v-if="invoiceAddress == true">
                    <i class="ti-check invoice-check bg-success text-white text-center border-circle mr-1"></i>
                    <div>{#delivery_address_info#}.<br>
                    {#invoice_address_info#}.</div>
                </div>
                <form :action="'/api/v1/public/address/' + $route.params.id" id="order-address-form" method="POST" class="w-100" ref="saveAddressForm" @submit.prevent="saveAddress()">
                    <div class="row" v-if="addressFields.rules">
                        <div class="col-12 col-sm-6" v-if="addressFields.configs && addressFields.configs.showCustomerEmailAddress == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="email" placeholder="{#email#}" name="email" :value="addressFields.configs.customerEmailAddress" class="form-control form-control-md">
                            </div>
                        </div>
                        <div class="col-12 col-sm-6">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <select v-model="addressDetail.is_company_active" name="is_company_active" id="is_company_active" class="col-12 form-control form-control-md" :data-validate="addressFields.rules.is_company_active.required == 1 ? 'required' : ''">
                                    <option value="0">{#individual_address#}</option>
                                    <option value="1">{#corporate_adress#}</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.title.show == 1 || addressFields.rules.title.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="text" placeholder="{#adress_title#}" name="title" id="title" class="col-12 form-control form-control-md" :data-validate="addressFields.rules.title.required == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.fullname.show == 1 || addressFields.rules.fullname.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="text" placeholder="{#fullname#}" name="fullname" id="fullname" class="col-12 form-control form-control-md" :data-validate="addressFields.rules.fullname.required == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.identity_number.show == 1 || addressFields.rules.identity_number.required == 1 " v-show="addressDetail.is_company_active == 0">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <div class="w-100">
                                    <input type="number" pattern="\d*" placeholder="{#identity_number#}" :disabled="addressDetail.nationality == 1" name="identity_number" id="identity_number" class="col-12 form-control form-control-md no-arrows" :data-validate="addressFields.rules.identity_number.required == 1 && addressDetail.nationality == 0 && addressDetail.is_company_active == 0 ? 'required' : ''">
                                </div>
                                <div class="h-100 d-flex align-items-center pr-1 position-absolute nationality-field-wrapper" v-if="addressFields.rules.nationality.show == 1 || addressFields.rules.nationality.required == 1">
                                    <input type="checkbox" name="nationality" id="nationality" class="form-control" :checked="addressDetail.nationality == 1" v-model="addressDetail.nationality">
                                    <label for="nationality" class="p-0 m-0">
                                        <span class="input-checkbox">
                                            <i class="ti-check"></i>
                                        </span>
                                        {#nationality#}
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.company.show == 1 || addressFields.rules.company.required == 1" v-show="addressDetail.is_company_active == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="text" placeholder="{#company#}" name="company" id="company" class="col-12 form-control form-control-md" :data-validate="addressFields.rules.company.required == 1 && addressDetail.is_company_active == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.tax_office.show == 1 || addressFields.rules.tax_office.required == 1" v-show="addressDetail.is_company_active == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="text" placeholder="{#tax_office#}" name="tax_office" id="tax_office" class="col-12 form-control form-control-md" :data-validate="addressFields.rules.tax_office.required == 1 && addressDetail.is_company_active == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.tax_number.show == 1 || addressFields.rules.tax_number.required == 1" v-show="addressDetail.is_company_active == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="number" pattern="\d*" placeholder="{#tax_number#}" name="tax_number" id="tax_number" class="col-12 form-control form-control-md no-arrows" :data-validate="addressFields.rules.tax_number.required == 1 && addressDetail.is_company_active == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.has_e_invoice.show == 1 || addressFields.rules.has_e_invoice.required == 1" v-show="addressDetail.is_company_active == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="checkbox" name="has_e_invoice" id="has_e_invoice" class="form-control" :checked="addressDetail.has_e_invoice == 1" :data-validate="addressFields.rules.has_e_invoice.required == 1 && addressDetail.is_company_active == 1 ? 'required' : ''">
                                <label for="has_e_invoice" class="p-0 m-0">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#has_e_invoice#}
                                </label>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 country-container" v-if="addressFields.rules.country.show == 1 || addressFields.rules.country.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative" v-if="addressFields.configs && addressFields.configs.eExportSystem == true">
                                <select name="country_code" id="country_code" class="col-12 form-control form-control-md eExport-select country-select" placaholder="{#country#} {#choose#}" :data-validate="addressFields.rules.country.required == 1 ? 'required' : ''">
                                    <option value="">{#country#} {#choose#}</option>
                                </select>
                                <a href="javascript:void(0)" class="eExport-btn"
                                data-toggle="popconfirm"
                                data-title="{#export_tooltip#}"
                                data-confirm="{#okey#}"
                                data-cancel="{#give_up#}"
                                data-callback="eExport"></a>
                                <div class="eExport-overlay d-none" @click="eExportOverlay"></div>
                            </div>
                            <div class="w-100 mb-1 popover-wrapper position-relative" v-else>
                                <select name="country_code" id="country_code" class="col-12 form-control form-control-md country-select" placaholder="{#country#} {#choose#}" :data-validate="addressFields.rules.country.required == 1 ? 'required' : ''">
                                    <option value="">{#country#} {#choose#}</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 state-container" v-if="addressFields.rules.province.show == 1 || addressFields.rules.province.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <div class="state-input-container">
                                    <input type="text" placeholder="{#province#}" id="province" name="province" class="form-control form-control-md state-input">
                                </div>
                                <div class="state-select-container">
                                    <select name="province_code" id="province_code" class="col-12 form-control form-control-md state-select" placeholder="{#province#} {#choose#}">
                                        <option value="">{#province#} {#choose#}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 city-container" v-if="addressFields.rules.city.show == 1 || addressFields.rules.city.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <div class="city-input-container">
                                    <input type="text" placeholder="{#city#}" id="city" name="city" class="form-control form-control-md city-input">
                                </div>
                                <div class="city-select-container">
                                    <select name="city_code" id="city_code" class="col-12 form-control form-control-md city-select" placeholder="{#city#} {#choose#}">
                                        <option value="">{#city#} {#choose#}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 town-container" v-if="addressFields.rules.town.show == 1 || addressFields.rules.town.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <div class="town-input-container">
                                    <input type="text" placeholder="{#town#}" id="town" name="town" class="form-control form-control-md town-input">
                                </div>
                                <div class="town-select-container">
                                    <select name="town_code" id="town_code" class="col-12 form-control form-control-md town-select" placeholder="{#town#} {#choose#}">
                                        <option value="">{#town#} {#choose#}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6 district-container" v-if="addressFields.rules.district.show == 1 || addressFields.rules.district.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <div class="district-input-container">
                                    <input type="text" placeholder="{#district#}" id="district" name="district" class="form-control form-control-md district-input">
                                </div>
                                <div class="district-select-container">
                                    <select name="district_code" id="district_code" class="col-12 form-control form-control-md district-select" placeholder="{#district#} {#choose#}">
                                        <option value="">{#district#} {#choose#}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-12" v-if="addressFields.rules.address.show == 1 || addressFields.rules.address.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <textarea placeholder="{#adress#}" name="address" id="address" class="col-12 form-control" :data-validate="addressFields.rules.address.required == 1 ? 'required' : ''">{{ addressDetail.address }}</textarea>
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.post_code.show == 1 || addressFields.rules.post_code.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="number" pattern="\d*" placeholder="{#post_code#}" name="post_code" id="post_code" class="col-12 form-control form-control-md no-arrows" :data-validate="addressFields.rules.post_code.required == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.mobile_phone.show == 1 || addressFields.rules.mobile_phone.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="tel" placeholder="{#mobile_phone#}" name="mobile_phone" id="mobile_phone" class="col-12 form-control form-control-md no-arrows" data-flag-masked :data-validate="addressFields.rules.mobile_phone.required == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="col-12 col-sm-6" v-if="addressFields.rules.home_phone.show == 1 || addressFields.rules.home_phone.required == 1">
                            <div class="w-100 mb-1 popover-wrapper position-relative">
                                <input type="tel" placeholder="{#home_phone#}" name="home_phone" id="home_phone" class="col-12 form-control form-control-md no-arrows" data-flag-masked :data-validate="addressFields.rules.home_phone.required == 1 ? 'required' : ''">
                            </div>
                        </div>
                        <div class="col-12" v-if="addresses.ADDRESS_LIST.length == 0 && invoiceAddress == false && storeTab != 1">
                            <div class="w-100 mt-1 mb-2 popover-wrapper position-relative">
                                <input type="checkbox" name="invoiceAddress" id="invoice-address" class="form-control" @change="setApiInvoice($event)">
                                <label for="invoice-address" class="p-0 m-0 d-flex align-items-center fw-regular">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                    {#invoice_address_check#}
                                </label>
                            </div>
                        </div>
                        <div class="w-100">
                            <div class="col-12 col-sm-6">
                                <button type="submit" class="btn btn-primary w-100 text-uppercase" ref="saveFormButton">{{ $route.params.id ? '{#update_address#}' : '{#save_address#}' }}</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<template id="order-payment">
    <div class="w-100 mb-1 payment-cargo-list" v-if="cargoCompanies.SHOW_CARGO_AREA == 1">
        <div class="d-flex align-items-center payment-list-title mb-1">
            <i class="ti-truck-o mr-1"></i> {#cargo_options#}
        </div>
        <div class="row cargo-options">
            <div class="col-12 col-md-6 mb-1" v-for="(c, i) in cargoCompanies.CARGO_COMPANY_LIST" :key="i">
                <input type="radio" name="paymentCargo" :id="'cargo-item-input-' + i" class="form-control" :data-id="c.ID" :checked="c.ID == cargoCompanies.SELECTED_COMPANY.ID" @change="cargoCompanies.SELECTED_COMPANY.ID = c.ID">
                <label :for="'cargo-item-input-' + i" class="w-100 h-100 p-1 fw-regular d-flex align-items-center mb-0 border cargo-option-item" :class="{'active': c.ID == cargoCompanies.SELECTED_COMPANY.ID }">
                    <span class="input-checkbox"><i class="ti-check"></i></span>
                    <div class="w-100 d-flex align-items-center ml-1">
                        <div class="cargo-logo d-none"><img src="https://via.placeholder.com/55x25" class="d-block" :alt="'cargo ' + i"></div>
                        <div class="cargo-content text-gray">
                            <strong class="fw-regular">{{ c.NAME }}</strong>
                            <p class="mb-0">{{ c.DESCRIPTION }}</p>
                        </div>
                        <div class="cargo-price ml-auto">{{ c.TOTAL }} {{ c.CURRENCY }}</div>
                    </div>
                </label>
            </div>
        </div>
    </div>
    <div class="w-100 mb-1 payment-cargo-list payment-cargo-services" v-if="cargoCompanies.SHOW_CARGO_AREA == 1 && cargoServices && cargoServices.HAS_SERVICE == 1 && cargoServices.SERVICES">
        <div class="w-100 mb-1">
            <div class="d-flex align-items-center payment-list-title">
                <i class="ti-calendar mr-1"></i> {#cargo_service_select#}
            </div>
            <div class="text-gray">{#cargo_service_info#}.</div>
        </div>
        <div class="d-flex align-items-center mb-1 cargo-options-service">
            <div v-for="(SERVICE, i) in cargoServices.SERVICES">
                <button class="btn text-left cargo-services-btn" v-if="SERVICE.STATUS == 1" :data-date="SERVICE.DATE"
                    :class="cargoCompanies.SELECTED_COMPANY.SERVICEDATE == SERVICE.DATE ? 'btn-primary text-white selected' : 'btn-light text-gray'"
                    @click="selectCargoService(SERVICE.ITEMS, SERVICE.DATE)">
                    {{ SERVICE.DATEF }}<br>{{ SERVICE.W }}
                </button>
            </div>
        </div>
        <div class="row cargo-options">
            <div class="col-12 col-md-6 mb-1" v-for="(item, i) in cargoServicesItems">
                <div class="cargo-services-item" :class="{'disabled' : item.STATUS == 0}">
                    <input type="radio" name="cargoServiceId" class="form-control" :id="'cargo-service-id-' + i" :value="item.STATUS == 1 ? item.ID : ''"
                    :checked="cargoCompanies.SELECTED_COMPANY.SERVICEID == item.ID"
                    @change="setCargoServices(item.ID)">
                    <label :for="'cargo-service-id-' + i" class="w-100 h-100 p-1 fw-regular d-flex align-items-center mb-0 border">
                        <span class="input-checkbox"><i class="ti-check"></i></span>
                        <div class="w-100 d-flex justify-content-between align-items-center text-gray">
                            <div><span>{{item.TIME_START}}</span> - <span>{{item.TIME_END}}</span></div>
                            <div class="text-uppercase text-body">
                                <span v-if="item.STATUS == 1">{#available#}</span>
                                <span v-else>{#not_available#}</span>
                            </div>
                        </div>
                    </label>
                </div>
            </div>
        </div>
    </div>
    <div class="w-100 mb-1 payment-type-list" v-if="Array.isArray(paymentTypeList.PAYMENT_LIST)">
        <div class="d-flex align-items-center payment-list-title mb-1">
            <i class="ti-credit-card mr-1"></i> {#payment_options#}
        </div>
        <div class="w-100 mb-1 border payment-list-item" :class="['payment-list-item' + payment.ID, {'active' : paymentID == payment.ID}]" v-for="(payment, pi) in paymentTypeList.PAYMENT_LIST" :key="pi">
            <div class="p-1 d-flex align-items-center accordion-title" data-toggle="accordion" :data-id="payment.ID" @click="setPaymentID(payment.ID)">
                <span class="input-checkbox mr-1"><i class="ti-check"></i></span> {{ payment.NAME }}
            </div>
            <div class="col-12 pb-1 accordion-body" v-if="payment.ID < -2">
                <div class="mb-1 text-gray" v-html="payment.DECLERATION"></div>
                <div class="row check-list-item" v-if="payment.OPTIONS.length > 0">
                    <div class="col-12" v-for="(row, optIndex) in payment.OPTIONS" :class="{ 'mb-1': (optIndex + 1) < payment.OPTIONS.length }">
                        <input type="radio" :name="'pay' + payment.ID" :id="'pay' + row.ID + optIndex" class="form-control" :value="row.ID" :checked="row.DEFAULT_VALUE == '1'">
                        <label :for="'pay' + row.ID + optIndex" class="w-100 h-100 p-1 fw-regular d-flex align-items-center mb-0 border text-gray">
                            <span class="input-checkbox"><i class="ti-check"></i></span>
                            {{ row.NAME }}
                        </label>
                    </div>
                </div>
            </div>
            <div class="col-12 pb-1 accordion-body" v-else-if="payment.ID > 0">
                <div class="mb-1 text-gray" v-html="payment.DECLERATION"></div>
                <div class="row check-list-item" v-if="payment.OPTIONS.length > 0">
                    <div class="col-12" v-for="(row, optIndex) in payment.OPTIONS" :class="{ 'mb-1': (optIndex + 1) < payment.OPTIONS.length }">
                        <input type="radio" :name="'pay' + payment.ID" :id="'pay' + row.ID + optIndex" class="form-control" :value="row.ID" :checked="row.DEFAULT_VALUE == '1'">
                        <label :for="'bank' + row.ID + optIndex" class="w-100 h-100 p-1 fw-regular d-flex align-items-center mb-0 border text-gray">
                            <span class="input-checkbox"><i class="ti-check"></i></span>
                            {{ row.NAME }}
                        </label>
                    </div>
                </div>
            </div>
            <div class="col-12 pb-1 accordion-body" v-else-if="payment.ID == -1">
                <div class="mb-1 text-gray" v-html="payment.DECLERATION"></div>
                <div class="payment-list-title border-bottom pb-1 my-1">{#bank_accounts#}</div>
                <div class="row check-list-item" v-if="paymentTypeList.BANK_LIST.length > 0">
                    <div class="col-12" v-for="(bank, bi) in paymentTypeList.BANK_LIST" :class="{ 'mb-1': (bi + 1) < paymentTypeList.BANK_LIST.length }">
                        <input type="radio" :name="'payment_' + payment.PAYMENTTYPE" :id="'bank' + bank.ID + bi" :value="bank.ID" class="form-control">
                        <label :for="'bank' + bank.ID + bi" class="w-100 h-100 p-1 fw-regular d-flex align-items-center mb-0 border text-gray">
                            <span class="input-checkbox"><i class="ti-check"></i></span>
                            <div class="w-100">
                                {{ bank.NAME }}, {{ bank.BRANCH }} - 
                                <span v-if="bank.ACCOUNT_NUMBER != ''">{#bank_account_no#}: {{ bank.ACCOUNT_NUMBER }} - </span> 
                                {{ bank.ACCOUNT_OWNER }} 
                                <span v-if="bank.IBAN != ''"> ({#iban#}: {{ bank.IBAN }})</span>
                                <span v-if="bank.CURRENCY != ''"> ({#currency#} : {{ bank.CURRENCY }})</span>
                                <span v-if="bank.SWIFT != ''"> ({#swift#} : {{ bank.SWIFT }})</span>
                            </div>
                        </label>
                    </div>
                </div>
            </div>
            <div class="col-12 pb-1 accordion-body" v-else-if="payment.ID == -2">
                <div class="row">
                    <div class="col-12 col-md-6 mb-1" v-if="payment.ISSINGLEPOSOOS != 1">
                        <div id="card-storage-list" class="col-12" v-if="cardStorageList.length > 0">
                            <div class="row">
                                <ul class="list-style-none check-list-item w-100">
                                    <li v-for="(card, i) in cardStorageList" :data-id="card.ID" class="w-100 mb-1 card-storage-item">
                                        <input :id="'card-storage-' + card.ID" type="radio" name="cStorageCardId" :value="card.ID" class="form-control" @change="cardStorageSelect(card.ID)">
                                        <label :for="'card-storage-' + card.ID" class="d-flex align-items-center border border-round bg-light p-1 m-0 w-100">
                                            <span class="input-radio"><i class="ti-circle"></i></span>
                                            <div class="w-100 d-flex align-items-center flex-wrap">
                                                <div class="mr-1">
                                                    <div><b>{{ card.CARD_ALIAS }}</b></div>
                                                    <div>{{ card.CARD_MASK }}</div>
                                                </div>
                                                <a href="javascript:void(0)" class="ml-auto text-body text-underline" @click="cardStorageDelete(card.ID)">{#delete#}</a>
                                            </div>
                                        </label>
                                    </li>
                                    <li class="w-100 mb-1">
                                        <input type="radio" id="cStorageCardId" name="cStorageCardId" value="" class="form-control" @change="cardStorageSelect(0)">
                                        <label for="cStorageCardId" class="d-flex align-items-center flex-wrap border border-round bg-light p-1 m-0">
                                            <span class="input-radio"><i class="ti-circle"></i></span>
                                            <div class="fw-bold">{#other_card_pay#}</div>
                                        </label>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div id="masterpass-card-list" class="col-12" v-if="masterPassCards.length > 0">
                            <div class="row">
                                <ul class="list-style-none check-list-item w-100">
                                    <li v-for="(card, i) in masterPassCards" class="w-100 mb-1">
                                        <input :id="'mpControlCardId' + i" type="radio" name="mpControlCardId" :value="card.UniqueId" class="form-control" onchange="masterPass.selectCard(this);">
                                        <label :for="'mpControlCardId' + i" class="d-flex align-items-center border border-round bg-light p-1 m-0 w-100">
                                            <span class="input-radio"><i class="ti-circle"></i></span>
                                            <div class="d-flex align-items-center flex-wrap">
                                                <img class="mr-1 masterpass-logo" src="/theme/standart/images/KrediKart/masterpass_logo.png">
                                                <div class="mr-1">
                                                    <div><b>{{ card.Name }}</b></div>
                                                    <div>{{ card.Value1 }}</div>
                                                </div>
                                            </div>
                                            <a href="javascript:void(0)" onclick="masterPass.deleteCard(this); return false;" :data-id="card.UniqueId" class="ml-auto text-body text-underline">{#delete#}</a>
                                        </label>
                                    </li>
                                    <li class="w-100 mb-1">
                                        <input type="radio" id="mpControlCardId" name="mpControlCardId" value="" class="form-control" onchange="masterPass.selectCard(this);">
                                        <label for="mpControlCardId" class="d-flex align-items-center flex-wrap border border-round bg-light p-1 m-0">
                                            <span class="input-radio"><i class="ti-circle"></i></span>
                                            <div class="fw-bold">{#other_card_pay#}</div>
                                        </label>
                                    </li>
                                    <li class="w-100 mb-1" id="masterPassCVVPanel" style="display:none;">
                                        <label class="d-flex">{#masterpass_cvc#} *</label>
                                        <div class="w-100 popover-wrapper">
                                            <input type="number" id="mpControlCVV" name="mpControlCVV" maxlength="4" class="form-control form-control-md no-arrows required" placeholder="CVC" autocomplete="off">
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="w-100" id="credit-cart-form">
                            <div class="payment-list-title border-bottom pb-1 mb-1">{#card_info#}</div>
                            <div class="w-100 d-flex flex-wrap mt-1 position-relative credit-card-wrapper">
                                <div class="card-item d-none d-md-block" :class="{ 'active' : creditCard.isCardFlipped }"  v-if="creditCard.isInputFocused">
                                    <div class="card-item-side front">
                                        <div class="card-item-cover">
                                            <img src="/theme/v5/images/credit-card-bg.svg" class="d-block card-item-bg">
                                        </div>
                                        <div class="card-item-wrapper">
                                            <div class="d-flex justify-content-flex-end card-item-top">
                                                <div class="card-item-type d-flex align-items-center justify-content-center border-round" :class="{ 'bg-white': getCardType }">
                                                    <transition name="slide-fade-up">
                                                        <img :src="'/theme/v5/images/' + getCardType + '.svg'" v-if="getCardType" v-bind:key="getCardType" alt="" class="card-item-typeimg">
                                                    </transition>
                                                </div>
                                            </div>
                                            <label for="cardNumber" class="card-item-number" ref="cardNumber">
                                                <template v-if="getCardType === 'amex'">
                                                    <span v-for="(n, index) in creditCard.amexCardMask">
                                                        <transition name="slide-fade-up">
                                                            <span class="card-item-numberItem" v-if="index > 4 && index < 14 && creditCard.cardNumber.length > index && n.trim() !== ''">*</span>
                                                            <span class="card-item-numberItem" :class="{ 'active' : n.trim() === '' }" v-else-if="creditCard.cardNumber.length > index">{{ creditCard.cardNumber[index] }}</span>
                                                            <span class="card-item-numberItem" :class="{ 'active' : n.trim() === '' }" v-else>{{ n }}</span>
                                                        </transition>
                                                    </span>
                                                </template>
                                                <template v-else>
                                                    <span v-for="(n, index) in creditCard.otherCardMask">
                                                        <transition name="slide-fade-up">
                                                            <span class="card-item-numberItem" v-if="index > 4 && index < 15 && creditCard.cardNumber.length > index && n.trim() !== ''">*</span>
                                                            <span class="card-item-numberItem" :class="{ 'active' : n.trim() === '' }" v-else-if="creditCard.cardNumber.length > index">{{ creditCard.cardNumber[index] }}</span>
                                                            <span class="card-item-numberItem" :class="{ 'active' : n.trim() === '' }" v-else>{{ n }}</span>
                                                        </transition>
                                                    </span>
                                                </template>
                                            </label>
                                            <div class="card-item-content">
                                                <div class="d-flex align-items-center justify-content-flex-end card-item-date" ref="cardDate">
                                                    <label for="expireMonth" class="card-item-dateTitle">{#effective_date#}</label>
                                                    <strong>
                                                        <label for="expireMonth" class="card-item-dateItem">
                                                            <transition name="slide-fade-up">
                                                                <span v-if="creditCard.expireMonth" :key="creditCard.expireMonth">{{ creditCard.expireMonth }}</span>
                                                                <span v-else>MM</span>
                                                            </transition>
                                                        </label>
                                                        /
                                                        <label for="expireYear" class="card-item-dateItem">
                                                            <transition name="slide-fade-up">
                                                                <span v-if="creditCard.expireYear" :key="creditCard.expireYear">{{ creditCard.expireYear }}</span>
                                                                <span v-else>YY</span>
                                                            </transition>
                                                        </label>
                                                    </strong>
                                                </div>
                                                <label for="cardHolder" class="w-100 card-item-info mb-0" ref="cardName">
                                                    <div class="card-item-name text-uppercase fw-bold border border-primary border-round" v-if="creditCard.cardHolder.length" v-html="creditCard.cardHolder"></div>
                                                    <div class="card-item-name text-uppercase fw-bold border border-primary border-round" v-else>{#fullname#}</div>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-item-side back">
                                        <div class="card-item-cover">
                                            <img src="/theme/v5/images/credit-card-bg-back.svg" class="d-block card-item-bg">
                                        </div>
                                        <div class="d-flex align-items-center justify-content-center card-item-cvv">
                                            <div class="card-item-cvvBand">
                                                    <span v-for="(n, index) in creditCard.cvc">*</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="cardType" :value="creditCard.cardType" />
                                <input type="hidden" name="creditCardCampaignCode" :value="creditCard.creditCardCampaignCode" />
                                <input type="hidden" name="installmentCount" :value="creditCard.installmentCount" />
                                <input type="hidden" name="installmentId" :value="creditCard.installmentId" />
                                <input type="hidden" name="posId" :value="creditCard.posId" />
                                <label for="cardHolder" class="fw-medium">{#card_holder#} *</label>
                                <div class="w-100 mb-1 popover-wrapper">
                                    <input type="text" id="cardHolder" name="cardHolder" autocomplete="off" class="form-control form-control-md required" placeholder="{#card_holder#}" @focus="focusInput" @blur="blurInput" v-model="creditCard.cardHolder">
                                </div>
                                <label for="cardNumber" class="fw-medium">{#card_number#} *</label>
                                <div class="w-100 mb-1 popover-wrapper">
                                    <input type="text" id="cardNumber" name="cardNumber" autocomplete="off" class="form-control form-control-md required" placeholder="{#card_number#}" v-model="creditCard.cardNumber" @focus="focusInput" @blur="blurInput" data-ref="cardNumber">
                                </div>
                                <div class="col-9">
                                    <div class="row">
                                        <label class="col-12 p-0 fw-medium">{#card_expire#} *</label>
                                        <div class="col-6 pl-0">
                                            <div class="w-100 popover-wrapper">
                                                <select id="expireMonth" name="expireMonth" class="form-control form-control-md required" v-model="creditCard.expireMonth" @focus="focusInput" @blur="blurInput">
                                                    <option value="">{#month#}</option>
                                                    <option v-for="i in 12" :disabled="i < minCardMonth" :value="i < 10 ? '0' + i : i">{{ i < 10 ? '0' + i : i }}</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-6 pl-0">
                                            <div class="w-100 popover-wrapper">
                                                <select id="expireYear" name="expireYear" class="form-control form-control-md required" v-model="creditCard.expireYear" @focus="focusInput" @blur="blurInput">
                                                    <option value="">{#year#}</option>
                                                    <option v-for="(year, index) in 12" :value="(index + creditCard.minCardYear).toString().slice(-2)">{{ index + creditCard.minCardYear }}</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="row">
                                        <div class="w-100 popover-wrapper">
                                            <label for="cvc" class="fw-medium">{#cvc#} *</label>
                                            <input type="number" id="cvc" name="cvc" maxlength="4" class="form-control form-control-md no-arrows required" placeholder="CVC" autocomplete="off" v-model="creditCard.cvc" @focus="flipCard(true)" @blur="flipCard(false)">
                                        </div>    
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="card-secured-3d" class="col-12 mt-1" v-show="secure3d == 2">
                            <div class="row">
                                <input type="checkbox" id="secure-3d-check" class="form-control" @change="setValsecure3d">
                                <label for="secure-3d-check">
                                    <span class="input-checkbox"><i class="ti-check"></i></span>{#3d_secure#}
                                </label>
                            </div>
                        </div>
                        <div id="card-cardstorage" class="col-12 mt-1" v-if="payment.CARDSTORAGE == 1">
                            <div class="row">
                                <input type="checkbox" id="card-save-control" class="form-control" :checked="paymentTypeList.SUBSCRIBE">
                                <label for="card-save-control" class="w-100 d-flex align-items-center" disabled v-if="paymentTypeList.SUBSCRIBE">
                                    <span class="input-checkbox"><i class="ti-check"></i></span>
                                    {#save_card#}
                                </label>
                                <label for="card-save-control" class="accordion-title w-100 d-flex align-items-center" data-toggle="accordion" v-else>
                                    <span class="input-checkbox"><i class="ti-check"></i></span>
                                    {#save_card#}
                                </label>
                                <div class="mt-1 col-12 p-1 bg-light border-round" :class="paymentTypeList.SUBSCRIBE == true ? '' : 'accordion-body'">
                                    <div class="w-100 popover-wrapper">
                                        <label>{#card_name_enter#} *</label>
                                        <input type="text" name="cardAliasControl" id="card-alias-control" class="form-control form-control-md" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="masterPassActive" id="masterpass-active" :value="payment.MASTERPASSCONF.isActive" />
                        <input type="hidden" name="masterPassGlobalActive" id="masterpass-global-active" :value="payment.MASTERPASSCONF.isGlobalActive"/>
                        <div id="masterpass-save-panel" class="col-12 mt-1">
                            <div class="row">
                                <div class="w-100 position-relative">
                                    <input type="checkbox" id="mp-save-control" class="form-control" @change="mpSave($event)">
                                    <label for="mp-save-control" class="accordion-title w-100 d-flex align-items-center" data-toggle="accordion">
                                        <span class="input-checkbox"><i class="ti-check"></i></span>
                                        {#masterpass_text#}
                                    </label>
                                    <div class="accordion-body mt-1 col-12 p-1 bg-light border-round">
                                        <div class="w-100 mb-2">
                                            <img class="masterpass-logo" src="/theme/standart/images/KrediKart/masterpass_logo.png">
                                            <div class="w-100">
                                                <div>{#masterpass_info#}. <a href="/Order/OrderAPI/masterPassTermofUse/1" class="text-primary text-underline popupwin">{#more_info#}</a></div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12 mb-1">
                                                <label class="w-100">{#card_name_enter#} *</label>
                                                <div class="w-100 popover-wrapper">
                                                    <input type="text" name="mpControlCardName" id="mp-control-card-name" class="form-control form-control-md" v-model="msCardName"/>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <label class="w-100">{#your_phone#} *</label>
                                                <div class="w-100 popover-wrapper">
                                                    <input type="text" name="mpControlPhoneNumber" id="mp-control-phone-number" class="form-control form-control-md" data-flag-masked v-model="setMsisdn"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="have-masterpass-global-account" style="display:none" class="col-12 mt-1">
                            <div class="row">
                                <a href="javascript:void(0)" class="text-primary text-underline d-flex align-items-center" onclick="masterPass.globalCheckout();return false;">
                                    <img class="mr-1" src="/theme/standart/images/KrediKart/mpGlobal.png" /> 
                                    {#masterpass_global#}
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6" v-else>
                        {#oss#}
                    </div>
                    <div class="col-12 col-md-6" v-show="insOpt.SHOW_INSTALLMENT || cardPoint.status">
                        <div class="row">
                            <div class="col-12 mb-1" id="credit-card-point" v-if="cardPoint.status">
                                <div class="row">
                                    <div class="col-12" v-if="cardPoint.step == 1">
                                        <div class="mb-1 fw-bold">{#bank_point#}</div>
                                        <button type="button" id="btn-getcardpoint" class="btn btn-primary w-100" @click="getCardPoint()">
                                            {#bank_point_enter#}
                                        </button>
                                    </div>
                                    <div class="col-12" v-if="cardPoint.step == 2">
                                        <div class="payment-list-title border-bottom pb-1 mb-1">{#use_point#}</div>
                                        <div class="row mt-1">
                                            <div class="col-12" v-for="(point, i) in cardPoint.pointList">
                                                <div class="fw-bold mb-1">{{ point.name }} - {{ format(point.amount) }}</div>
                                                <div class="col-12">
                                                    <div class="row">
                                                        <label :for="'card-gift' + i">{#use_point_enter#}</label>
                                                        <div class="w-100 mb-1 popover-wrapper">
                                                            <input type="text" :id="'card-gift' + i" class="card-gift-amount-control form-control form-control-md" :data-type="point.type" @keyup="cardpointAll(null, 'card-gift-all' + i)">
                                                        </div>
                                                        <input type="checkbox" :id="'card-gift-all' + i" class="form-control" @change="cardpointAll(point.amount, 'card-gift' + i)">
                                                        <label :for="'card-gift-all' + i" class="m-0">
                                                            <span class="input-checkbox"><i class="ti-check"></i></span>
                                                            {#use_all#}
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12" v-show="insOpt.SHOW_INSTALLMENT && insOpt.INSTALLMENTS.length > 0">
                                <div class="payment-list-title border-bottom pb-1 mb-1 d-flex align-items-center justify-content-between">
                                    {#installment_options#}
                                    <a :href="'/srv/service/content-v5/sub-folder/91/1119/installment/' + cardNumberFirst6Char" data-width="1200" class="installment-popup btn btn-light border popupwin">{#installment_table#}</a>
                                </div>
                                <div class="w-100 px-1 d-flex flex-direction-column flex-wrap border border-round card-installment" ref="installmentOptions">
                                    <div class="row align-items-center border-bottom text-body card-installment-header">
                                        <div class="col-4 fw-bold text-left">{#installment_numbers#}</div>
                                        <div class="col-4 fw-bold text-center">{#monthly_payment#}</div>
                                        <div class="col-4 fw-bold text-right">{#total_price#}</div>
                                    </div>
                                    <div class="row text-body card-installment-item">
                                        <div class="col-4 border-right text-left">
                                            <input type="radio" name="ins-opt" id="ins-opt-0" value="0" class="form-control" checked @change="setInstallment({
                                                CREDIT_DEBIT: insOpt.CREDIT_DEBIT,
                                                INSTALLMENT: 0,
                                                ID: 0,
                                                POS_ID: insOpt.SINGLE_POS_ID,
                                            })">
                                            <label for="ins-opt-0" class="mb-0">
                                                <span class="input-checkbox"><i class="ti-check"></i></span> 
                                                {#single_pos#}
                                            </label>
                                        </div>
                                        <div class="col-4 border-right text-center insPrice">{{ insOpt.SINGLE_POS_PRICE }} {{ insOpt.CURRENCY }}</div>
                                        <div class="col-4 text-right totalPrice">{{ insOpt.SINGLE_POS_PRICE }} {{ insOpt.CURRENCY }}</div>
                                    </div>
                                    <div class="row border-top text-body card-installment-item" v-for="installment in insOpt.INSTALLMENTS">
                                        <div class="col-4 border-right text-left">
                                            <input type="radio" name="ins-opt" :id="'ins-opt-' + installment.ID" :value="installment.ID" class="form-control" @change="setInstallment(installment)">
                                            <label :for="'ins-opt-' + installment.ID" class="mb-0">
                                                <span class="input-checkbox"><i class="ti-check"></i></span> 
                                                {{ installment.INSTALLMENT }} <span v-if="installment.PLUS_INSTALLMENT"> + {{ installment.PLUS_INSTALLMENT }}</span> {#installment#}
                                            </label>
                                        </div>
                                        <div class="col-4 border-right text-center insPrice">{{ installment.PRICE_INSTALLMENT }} {{ insOpt.CURRENCY }}</div>
                                        <div class="col-4 text-right totalPrice">{{ installment.PRICE_TOTAL }} {{ insOpt.CURRENCY }}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="w-100 p-1 mb-1 border payment-list-item" v-if="paymentTypeList.ACTIVE_PRICE_LIMIT > 0">
            {#no_active_payment_type_for_amount_1#} {{ paymentTypeList.ACTIVE_PRICE_LIMIT }} {{ summaryData.CURRENCY }} {#no_active_payment_type_for_amount_2#}
        </div>
        <div class="w-100 p-1 mb-1 border payment-list-item" v-if="paymentTypeList.PAYMENT_LIST.length < 1 && paymentTypeList.FAULT_MESSAGES.length > 0">
            <ul>
                <li v-for="fm in paymentTypeList.FAULT_MESSAGES">{{ fm }}</li>
            </ul>
        </div>
    </div>
</template>

<template id="order-approve">
    <div class="w-100 py-3" id="approve-step">
        <div class="text-primary approve-title mb-1 fw-bold d-flex align-items-center"><i class="ti-check mr-1"></i> {#approve_title#} !</div>
        <div class="row align-items-center">
            <div class="col-12 col-md-7">
                <div class="mb-1 approve-description" v-html="approveData.statusText"></div>
                <div class="row approve-buttons">
                    <div class="col-12 col-md-6 mb-1">
                        <a href="/index.php" class="d-flex align-items-center w-100 h-100 btn btn-dark text-uppercase"><i class="ti-arrow-left mr-auto"></i> {#back_shopping#}</a>
                    </div>
                    <div class="col-12 col-md-6 mb-1">
                        <a href="/{url type='page' id='4'}" class="d-flex align-items-center w-100 h-100 btn btn-primary text-uppercase">{#my_orders#} <i class="ti-arrow-right ml-auto"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-5">
                <div class="my-1 h-100 d-flex align-items-center justify-content-center">
                    <img :src="'/theme/' + themeFolder + '/assets/approve.png'">
                </div>
            </div>
        </div>
    </div>
</template>