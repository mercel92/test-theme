<div id="page-my-order" class="w-100" v-cloak>
    <div class="col-12">
        <router-view></router-view>
    </div>
</div>
<template id="order-list">
    <div class="row">
        <div class="col-12 mb-1 pt-1 bg-white page-title-wrapper">
            <div class="d-flex align-items-flex-start justify-content-between">
                <h1 class="d-flex align-items-center">
                    <i class="ti-basket ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                    {#block_title#}
                </h1>
                <div class="d-flex align-items-center">
                    <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
            </div>
            <div class="w-100 border-top mt-1"></div>
        </div>
        <div class="col-12 mb-1 d-flex justify-content-flex-end">
            <input type="checkbox" id="is-archive-input" class="form-control get-old-order-input" @change="IS_ARCHIVE = !IS_ARCHIVE">
            <label for="is-archive-input" class="btn btn-light border border-light mb-0 fw-semibold d-flex align-items-center">
                <span class="input-checkbox">
                    <i class="ti-check"></i>
                </span>
                {#old_orders#}
            </label>
            <select class="form-control form-control-md w-auto d-inline-block pr-2 border border-light fw-semibold select-filter-order ml-1" v-model="FILTER_BY_DAY">
                <option value="">{#all#}</option>
                <option value="30">{#last_one_month#}</option>
                <option value="90">{#last_three_month#}</option>
                <option value="360">{#last_six_month#}</option>
            </select>
        </div>
        <div class="col-12 order-list">
            <div class="row mx-0">
                <div class="col-12 py-1 mb-1 border border-light border-round text-center text-body fw-semibold no-orders-text" v-if="!DATA.ORDERS">
                    {#no_result_orders#}.
                </div>
                <div class="col-12 px-0 mb-1 d-flex flex-wrap border border-light border-round order-item" v-for="(ORDER, index) in DATA.ORDERS">
                    <div class="col-auto py-1 order-mobile-btns">
                        <span class="bg-white order-no border border-light border-circle d-flex align-items-center justify-content-center fw-bold text-body">{{ DATA.START + index + 1 }}</span>
                        <router-link :to="'/detail/' + ORDER.ORDER_NUMBER" class="border border-light border-circle bg-white fw-bold text-body d-md-none order-no d-flex align-items-center justify-content-center"><i class="ti-arrow-right"></i></router-link>
                    </div>
                    <div class="col-6 col-md py-1">
                        <strong>{#date#}</strong>
                        <div>{{ ORDER.DATE.replace(/<\/?[^>]+(>|$)/g, " | ") }}</div>
                    </div>
                    <div class="col-6 col-md py-1">
                        <strong>{#order_no#}</strong>
                        <div>{{ ORDER.ORDER_NUMBER }}</div>
                    </div>
                    <div class="col-6 col-md py-1">
                        <strong>{#status#}</strong>
                        <div class="text-success"><i class="ti-box"></i> {{ ORDER.STATUS_TEXT }}</div>
                    </div>
                    <div class="col-6 col-md py-1">
                        <strong class="text-primary">{{ ORDER.TOTAL_PRICE }} {{ ORDER.CURRENCY }}</strong>
                        <div>{{ ORDER.PAYMENT_METHOD }}</div>
                    </div>
                    <div class="col-md-6 col-lg py-1 d-none d-md-block">
                        <button class="btn btn-light border border-light" v-if="ORDER.RETURNS.length > 0">{{ ORDER.RETURNS.length }} {#return_has#}</button>
                    </div>
                    <div class="col-md-6 col-lg py-1 d-none d-md-block">
                        <router-link :to="'/detail/' + ORDER.ORDER_NUMBER" class="btn btn-light border border-light">{#order_detail#}</router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 bg-light p-1 mb-1 d-flex justify-content-center align-items-center pagination" v-if="DATA.TOTAL > DATA.LENGTH">
        <a href="javascript:void(0);" class="prev" :class="DATA.START > 0 ? '' : 'passive'" @click="load(DATA.START - DATA.LENGTH)"><i class="ti-angle-left mr-1"></i>Önceki</a>
        <a href="javascript:void(0);" class="next" :class="DATA.START + DATA.LENGTH < DATA.TOTAL ? '' : 'passive'" @click="load(DATA.START + DATA.LENGTH)">Sonraki <i class="ti-angle-right ml-1"></i></a>
    </div>
</template>

<template id="order-detail">
    <div class="w-100">
        <div v-if="LOADING" v-cloak></div>
        <div class="row" v-else>
            <div class="col-12 mb-1 pt-1 bg-white page-title-wrapper">
                <div class="d-flex align-items-flex-start justify-content-between">
                    <h1 class="d-flex flex-wrap align-items-center">
                        <i class="ti-basket ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                        <span>
                            {#order_detail#}
                            <small class="d-block fw-regular text-body">{#order_no#}: {{ DETAIL.ORDER_NUMBER }}</small>
                        </span>
                    </h1>
                    <div class="d-flex align-items-center">
                        <a href="javascript:void(0);" @click="$router.go(-1)" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                    </div>
                </div>
                <div class="w-100 border-top mt-1"></div>
            </div>
            <div class="col-12 order-detail">
                <div class="row">
                    <div class="col-12 col-md-8">
                        <div class="w-100 border border-light border-round detail-card">
                            <nav class="w-100 pt-1 order-process">
                                <ul class="w-100 clearfix">
                                    <li class="w-25 px-1 d-flex align-items-center position-relative border-bottom border-success passed">
                                        <i class="ti-basket"></i>
                                        <span>
                                            {#order_buy#}
                                            <small class="d-block">{{ DETAIL.DATE.replace(/<\/?[^>]+(>|$)/g, " | ") }}</small>
                                        </span>
                                        <em class="process-dot border-circle position-absolute"></em>
                                    </li>
                                    <li class="w-25 px-1 d-flex align-items-center position-relative border-bottom" :class="DETAIL.STATUS_ID > 2 ? 'border-success passed' : 'border-light'">
                                        <i class="ti-clipboard"></i>
                                        <span>{#order_get_ready#}</span>
                                        <em class="process-dot border-circle position-absolute"></em>
                                    </li>
                                    <li class="w-25 px-1 d-flex align-items-center position-relative border-bottom" :class="DETAIL.STATUS_ID > 5 ? 'border-success passed' : 'border-light'">
                                        <i class="ti-truck-o"></i>
                                        <span>
                                            {#cargo_given#}
                                            <small class="d-block" v-if="DETAIL.STATUS_ID < 8">{#follow#}</small>
                                        </span>
                                        <em class="process-dot border-circle position-absolute"></em>
                                    </li>
                                    <li class="w-25 px-1 d-flex align-items-center position-relative border-bottom" :class="DETAIL.STATUS_ID > 7 ? 'border-success passed' : 'border-light'">
                                        <i class="ti-box"></i>
                                        <span>{#order_delivered#}</span>
                                        <em class="process-dot border-circle position-absolute"></em>
                                    </li>
                                </ul>
                            </nav>
                            <div class="w-100 p-1 order-product-list">
                                <h6>{#products#}</h6>
                                <nav class="product-list border border-light border-round">
                                    <ul class="clearfix">
                                        <li class="w-100 p-1" :class="{ 'border-bottom border-light': DETAIL.PRODUCT_LIST.length != (index + 1) }" v-for="(P, index) in DETAIL.PRODUCT_LIST">
                                            <div class="row mb-1" v-if="P.RETURN_STATUS">
                                                <div class="col col-12 fw-bold text-primary">
                                                    {{ P.RETURN_STATUS }}
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3 col-md-2">
                                                    <a :href="'/' + P.URL" target="_blank" class="image-wrapper">
                                                        <figure class="image-inner">
                                                            <img :src="P.IMAGE" :alt="P.TITLE">
                                                        </figure>
                                                    </a>
                                                </div>
                                                <div class="col-9 col-md-10">
                                                    <div class="row">
                                                        <div class="col-12 col-md-6">
                                                            <a :href="'/' + P.URL" target="_blank" class="text-body product-title">{{ P.TITLE }}</a>
                                                        </div>
                                                        <div class="col-6 col-md-3 text-body product-unit">
                                                            <p class="fw-bold">{{ P.UNIT || 'Adet' }}</p>
                                                            <div>{{ P.COUNT }}</div>
                                                        </div>
                                                        <div class="col-6 col-md-3 text-right product-total-price">
                                                            <p class="fw-bold">Birim Fiyat</p>
                                                            <div>{{ price(P.PRICE_TOTAL) }} {{ P.CURRENCY }}</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <div class="row mt-1 address-detail">
                            <div class="col-12 col-md-6 py-1 address-item" v-for="(ADDRESS, index) in DETAIL.ADDRESS">
                                <div class="w-100 h-100 border border-light border-round">
                                    <div class="p-1 address-title border-bottom border-light fw-bold"
                                    v-html="index == 'DELIVERY' ? '{#delivery_address#}' : '{#invoice_address#}'">
                                    </div>
                                    <div class="p-1 address-body text-content">
                                        <p v-html="ADDRESS.ADDRESS + ADDRESS.DISTRICT"></p>
                                        <p>{{ ADDRESS.TOWN }} / {{ ADDRESS.CITY }} / {{ ADDRESS.COUNTRY }}</p>
                                        <p v-if="ADDRESS.ZIP_CODE">{{ ADDRESS.ZIP_CODE }}</p>
                                        <p class="mb-0">{{ ADDRESS.MOBILE_PHONE }}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="w-100 p-1 border border-light border-round order-price-table">
                            <p class="text-content d-flex align-items-center justify-content-flex-end">
                                <span class="d-block w-50">{#cargo_price#}</span>
                                <span class="d-block w-50 text-right">{{ DETAIL.CARGO_PRICE }} {{ DETAIL.CURRENCY }}</span>
                            </p>
                            <p class="text-content d-flex align-items-center justify-content-flex-end">
                                <span class="d-block w-50">{#service_price#}</span>
                                <span class="d-block w-50 text-right">{{ DETAIL.SERVICE_PRICE }} {{ DETAIL.CURRENCY }}</span>
                            </p>
                            <p class="text-content text-primary fw-bold d-flex align-items-center justify-content-flex-end">
                                <span class="d-block w-50">{#general_total#}</span>
                                <span class="d-block w-50 text-right">{{ DETAIL.TOTAL_PRICE }} {{ DETAIL.CURRENCY }}</span>
                            </p>
                            <p class="text-content text-black fw-bold mb-0 d-flex align-items-center justify-content-flex-end">
                                <span class="d-block w-50">{#payment#}</span>
                                <span class="d-block w-50 text-right">{{ DETAIL.PAYMENT_METHOD }}</span>
                            </p>
                        </div>
                        <div class="mt-1 w-100">
                            <button type="button" class="btn btn-primary w-100 mb-1" v-if="ORDER_REPEAT == 1" @click="repeatOrder">{#repeat#}</button>
                            <div class="w-100" v-if="['9', '10', '1000'].includes(DETAIL.STATUS_ID) == false">
                                <button type="button" class="btn btn-black w-100 mb-1" v-if="DETAIL.ORDER_CANCEL == 1">{#cancel#}</button>
                                <router-link :to="'/return/' + DETAIL.ID" class="btn btn-black w-100 mb-1" v-if="DETAIL.ORDER_CANCEL != 1 && DETAIL.ORDER_RETURN == 1">{#create_return#}</router-link>
                                <span class="btn btn-black w-100 mb-1" v-if="DETAIL.ORDER_CANCEL != 1 && DETAIL.ORDER_RETURN != 1">{#time_over#}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<template id="order-return">
    <div class="w-100 mb-2">
        <div v-if="LOADING" v-cloak></div>
        <div class="row" v-else>
            <div class="col-12 mb-1 pt-1 bg-white page-title-wrapper">
                <div class="d-flex align-items-flex-start justify-content-between">
                    <h1 class="d-flex flex-wrap align-items-center">
                        <i class="ti-basket ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                        <span>
                            {#return_form#}
                            <small class="d-block fw-regular text-body">{#order_no#}: {{ DATA.ORDER.ORDER_NUMBER }}</small>
                        </span>
                    </h1>
                    <div class="d-flex align-items-center">
                        <a href="javascript:void(0);" @click="$router.go(-1)" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                    </div>
                </div>
                <div class="w-100 border-top mt-1"></div>
            </div>
            <form :action="'/srv/service/order-v5/order-return-save/' + $route.params.id" ref="orderReturnForm" enctype="multipart/form-data" method="post" @submit.prevent="saveForm" autocomplete="off" class="col-12 return-page-form">
                <input type="hidden" name="order_id"  :value="DATA.ORDER.ID">
                <input type="hidden" name="return_id" :value="DATA.RETURN_DATA.ID">
                <input type="hidden" name="fullname"  :value="DATA.IS_ACTIVE_RETURN_PROCESS == 1 ? DATA.RETURN_DATA.CUSTOMER_NAME : DATA.ORDER.CUSTOMER_FIRSTNAME">
                <input type="hidden" name="email"     :value="DATA.IS_ACTIVE_RETURN_PROCESS == 1 ? DATA.RETURN_DATA.CUSTOMER_EMAIL : DATA.ORDER.CUSTOMER_EMAIL">
                <div class="row">
                    <div class="col-12 mb-1 text-content">{#dear#} {{ DATA.ORDER.CUSTOMER_FIRSTNAME }} {{ DATA.ORDER.CUSTOMER_LASTNAME }}, {#return_form_info#}.</div>
                    <div class="col-12 col-md-6">
                        <h6>Ürünler</h6>
                        <div class="w-100 product-list">
                            <div class="col-12 mb-1 border border-light border-round" v-show="P.COUNT > 0" v-for="P in DATA.ORDER_PRODUCTS">
                                <div class="row">
                                    <div class="col-3 py-1 border-right border-light">
                                        <div class="image-wrapper bg-light border-round">
                                            <figure class="image-inner">
                                                <img :src="P.IMG" :alt="P.PRODUCT_NAME">
                                            </figure>
                                            <input type="checkbox" name="product_list[]" :id="'product_list' + P.ID" :value="P.ID" class="form-control product-list-select">
                                            <label :for="'product_list' + P.ID" class="border-round">
                                                <span class="input-checkbox m-0">
                                                    <i class="ti-check"></i>
                                                </span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-9 py-1 text-content">
                                        <div class="fw-bold mb-1 order-product-brand" v-if="P.BRAND != ''">{{ P.BRAND }}</div>
                                        <div class="mb-1 order-product-title">{{ P.PRODUCT_NAME }} {{ P.SUBPRODUCT_NAME }}</div>
                                        <div class="w-100 return-count-and-desc d-flex flex-wrap">
                                            <div class="w-100 w-md-50 pr-1">
                                                <label :for="'product_count_' + P.ID">{#return_amount#}</label>
                                                <select class="form-control form-control-md w-100 w-md-75 w-lg-50" 
                                                    :id="'product_count_' + P.ID" 
                                                    :name="'product_count_' + P.ID">
                                                    <option v-for="i in P.COUNT" :value="i">{{ i }}</option>
                                                </select>
                                            </div>
                                            <div class="w-100 w-md-50 pr-1">
                                                <label :for="'product_message_' + P.ID">{#return_description#}</label>
                                                <textarea :id="'product_message_' + P.ID" :name="'product_message_' + P.ID" maxlength="150" class="form-control form-control-sm">
                                                    {{ P.RETURN_DATA.DESCRIPTION }}
                                                </textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6">
                        <h6>&nbsp;</h6>
                        <div class="w-100 p-1 border border-light border-round position-sticky">
                            <label for="address" class="px-1 text-content fw-bold">{#your_adress#}</label>
                            <div class="col-12 mb-1">
                                <div class="w-100 popover-wrapper position-relative">
                                    <textarea id="address" name="address" class="form-control form-control-sm" data-validate="required"></textarea>
                                </div>
                            </div>
                            <label for="return_reason" class="px-1 text-content fw-bold">{#return_iban#}</label>
                            <div class="col-12 mb-1">
                                <div class="w-100 popover-wrapper position-relative">
                                    <textarea id="return_reason" name="return_reason" class="form-control form-control-sm" data-validate="required"></textarea>
                                </div>
                            </div>
                            <div class="col-12 mb-1" v-if="DATA.RETURN_REASON_TYPES.length > 0">
                                <label for="return_reason_type" class="text-content fw-bold">{#return_reason#}</label>
                                <div class="w-100 popover-wrapper position-relative">
                                    <select id="return_reason_type" name="return_reason_type" class="form-control form-control-md" data-validate="required">
                                        <option value="">{#choose#}</option>
                                        <option v-for="TYPE in DATA.RETURN_REASON_TYPES" :value="TYPE.id" :selected="TYPE.selected == 1">{{ TYPE.name }}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-12 mb-1" v-if="DATA.SHIPMENT.CARGO_COMPANIES.length > 0 && DATA.SHIPMENT.CREATE_CODE > 0">
                                <label for="cargo_company" class="text-content fw-bold">{#cargo_company#}</label>
                                <div class="w-100 popover-wrapper position-relative">
                                    <select id="cargo_company" name="cargo_company" class="form-control form-control-md" data-validate="required">
                                        <option value="">{#choose#}</option>
                                        <option v-for="CARGO in DATA.SHIPMENT.CARGO_COMPANIES" :value="CARGO.id" :selected="CARGO.id == DATA.RETURN_DATA.CARGO_COMPANY">{{ CARGO.company }}</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-12 mb-1">
                                <div class="w-100 position-relative popover-wrapper">
                                    <input type="file" name="img" id="input-file-img" class="form-control" ref="inputfile">
                                    <label for="input-file-img" class="form-control form-control-md d-flex align-items-center justify-content-between text-content">
                                        <span>{#file#} {#choose#}</span>
                                        <i class="ti-picture text-primary"></i>
                                    </label>
                                </div>
                            </div>
                            <div class="col-12 mb-1">
                                <div class="w-100 input-group popover-wrapper">
                                    <div class="input-group-prepend">
                                        <img :src="CAPTCHA" id="security_code">
                                    </div>
                                    <input type="text" name="security_code" class="form-control form-control-md" placeholder="{#security_code#}" data-validate="required">
                                    <div class="input-group-append" @click="refreshCode">
                                        <i class="ti-cw text-primary"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="w-100 btn btn-primary">{#return_form_send#}</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</template>