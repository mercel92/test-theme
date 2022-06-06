<div id="cart-page" class="w-100 mb-1 pos-r" v-cloak>
    <div class="col-12" v-if="!LOADING">
        <div class="row" v-if="CART.PRODUCTS.length < 1">
            <div class="col-12 py-1">
                <div class="bg-light px-1 py-2 text-body text-center fw-bold">{{ CART.ERROR }}</div>
            </div>
        </div>
        <div class="row" v-else>
            <div class="col-12 col-md-9">
                <div class="row align-items-center justify-content-between off-print">
                    <div class="col py-1">
                        <div class="cart-block-title text-uppercase d-flex align-items-center">
                            <i class="ti-basket-outline"></i> {#my_cart#}
                        </div>
                    </div>
                    <div class="col-auto py-1">
                        <a href="javascript:void(0)" @click="back()" id="cart-back-btn" class="btn btn-gray text-uppercase">
                            {#continue_shopping#}
                        </a>
                    </div>
                </div>
                <div class="w-100">
                    <div class="col-12 mb-1 border border-light cart-item position-relative cart-product" v-for="(P, index) in CART.PRODUCTS">
                        <div class="row">
                            <div class="col-cart-img my-1">
                                <a :href="'/' + P.URL" class="image-wrapper">
                                    <figure class="image-inner">
                                        <img :src="P.IMAGE.SMALL" :alt="P.TITLE">
                                    </figure>
                                </a>
                            </div>
                            <div class="col">
                                <div class="row">
                                    <div class="col-12 col-lg-6 py-1">
                                        <div class="cart-product-brand d-flex" v-if="P.BRAND">
                                            <a :href="'/' + P.BRAND_URL" class="fw-bold text-black" target="_blank">{{ P.BRAND }}</a>
                                        </div>
                                        <div class="cart-product-name d-flex">
                                            <a :href="'/' + P.URL" class="cart-product-title text-body" target="_blank">
                                                {{ P.TITLE }} 
                                                <span class="cart-product-variant-name text-primary" v-if="P.VARIANT1_NAME || P.VARIANT2_NAME">
                                                    <span v-if="P.VARIANT1_NAME">{{ P.VARIANT1_NAME }}</span> <span v-if="P.VARIANT2_NAME">{{ P.VARIANT2_NAME }}</span>
                                                </span>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-12 col-lg-6 py-1">
                                        <div class="row">
                                            <div class="col-auto col-lg-5 text-lg-center">
                                                <div class="qty cart-product-qty d-inline-block" data-toggle="qty" 
                                                    :data-callback="'qtyIncrease' + BLOCK.ID" 
                                                    :data-increment="P.STOCK_INCREMENT"
                                                    :data-pid="index">
                                                    <span :id="'qty-minus' + P.ID + P.CART_ID" class="ti-minus" @click="P.COUNT == 1 ? deleteItem(P) : ''" :class="{'ti-trash-o' : P.COUNT == 1}"></span>
                                                    <input type="number" 
                                                        :id="'qty' + P.ID + P.CART_ID"
                                                        :min="P.MIN_ORDER_COUNT" 
                                                        :max="P.STOCK" 
                                                        :step="P.STOCK_INCREMENT" 
                                                        v-model="P.COUNT" 
                                                        class="form-control text-center no-arrows">
                                                    <span :id="'qty-plus' + P.ID + P.CART_ID" class="ti-plus"></span>
                                                </div>
                                            </div>
                                            <div class="col-auto col-lg-5 text-lg-center">
                                                <div v-if="P.DISPLAY_VAT == 0" class="cart-product-price-wrapper">
                                                    <div class="price-not-discounted text-delete text-gray" v-if="P.PRICE_NOT_DISCOUNTED != P.PRICE_SELL && P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1">
                                                        {{ format(P.PRICE_NOT_DISCOUNTED) }} {{ P.TARGET_CURRENCY }} + %{{ P.VAT }} {#vat#}
                                                    </div>
                                                    <div class="price-sell fw-bold text-primary">{{ format(P.PRICE_SELL) }} {{ P.TARGET_CURRENCY }} + %{{ P.VAT }} {#vat#}</div>
                                                </div>
                                                <div v-else class="cart-product-price-wrapper">
                                                    <div class="price-not-discounted text-delete text-gray" v-if="P.PRICE_NOT_DISCOUNTED != P.PRICE_SELL && P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1">
                                                        {{ vat(P.PRICE_NOT_DISCOUNTED, P.VAT) }} {{ P.TARGET_CURRENCY }}
                                                    </div>
                                                    <div class="price-sell fw-bold text-black">{{ vat(P.PRICE_SELL, P.VAT) }} {{ P.TARGET_CURRENCY }}</div>
                                                </div>
                                            </div>
                                            <div class="col-auto col-lg-2 text-lg-center ml-auto">
                                                <a href="javascript:void(0);" :id="'delete-product-' + P.ID + P.CART_ID" class="cart-product-delete text-body border border-circle border-light" @click="deleteItem(P)">
                                                    <i class="ti-trash-o"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center flex-wrap cart-product-buttons">
                                    <div class="gift-package-btn mb-1 mr-1" v-if="CART.HAS_GIFT == 1 && P.CAMPAIGN_PERCENT != 100 && CART.IS_GENERAL_GIFT_PACKAGE == 0">
                                        <input type="checkbox" 
                                            name="HedPakDizi"
                                            class="form-control" 
                                            :id="'HedPakDizi' + P.CART_ID" 
                                            :value="P.CART_ID" 
                                            :checked="P.IS_GIFT_PACKAGE_ACTIVE == 1"
                                            @change="giftPackage(index)">
                                        <label :for="'HedPakDizi' + P.CART_ID" class="d-flex align-items-center fw-regular m-0">
                                            <span class="input-checkbox">
                                                <i class="ti-check"></i>
                                            </span>
                                            <span>{#gift_package_add#}</span>
                                            <span v-if="CART.GIFT_PACKAGE_COST > 0">+ {{ format(CART.GIFT_PACKAGE_COST) }} {{ CART.TARGET_CURRENCY }}</span>
                                        </label>
                                    </div>
                                    <a v-if="CART.HAS_GIFT == 1 && CART.IS_GENERAL_GIFT_PACKAGE == 0" href="#cart-page-panel" :id="'gift-btn' + P.CART_ID" data-toggle="drawer" class="btn mb-1 mr-1" 
                                        :class="P.GIFT_NOTES != '' ? 'btn-outline-primary' : 'btn-light'" @click="CART._showPanelType = 'gift_package_note' + index">
                                        <i class="ti-pencil"></i> {#gift_note#}
                                    </a>
                                    <a href="#cart-page-panel" :id="'order-notes-btn' + P.CART_ID" data-toggle="drawer" class="btn mb-1 mr-1" 
                                        :class="P.ORDER_NOTES != '' ? 'btn-outline-primary' : 'btn-light'" @click="CART._showPanelType = 'product_order_note' + index">
                                        <i class="ti-pencil"></i> {#order_note#}
                                    </a>
                                    <select :id="'subscribe-' + P.CART_ID + '-' + P.ID" class="form-control btn btn-outline-primary mb-1 mr-1 cart-product-subscribe" @change="setSubscribe(index, $event)" v-if="P.SUBSCRIBE != 0">
                                        <option :value="FREQUENCY" :selected="FREQUENCY == P.SUBSCRIBE_FREQUENCY" v-for="FREQUENCY in P.SUBSCRIBE_FREQUENCY_LIST">{{ FREQUENCY }}</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="w-100 off-print mb-2">
                    <div class="row">
                        <div class="w-100 d-flex cart-page-buttons">
                            <div class="col-auto" v-if="CART.FAVOR_COUPON != ''">
                                <button :id="'add-to-fav-btn-' + BLOCK.ID" class="btn text-gray d-flex align-items-center" @click="addToFav">
                                    <i class="ti-heart-o"></i> <u>{#add_fav_list#}</u>
                                </button>
                            </div>
                            <div class="col-auto" v-if="CART.IS_BID_BUTTON_ACTIVE == 1">
                                <a href="/srv/service/content-v5/sub-folder/30/1054/offer" :id="'offerBtn' + BLOCK.ID" data-width="800" class="btn text-gray d-flex align-items-center popupwin">
                                    <i class="ti-tag"></i> <u>{#ask_offer#}</u>
                                </a>
                            </div>
                            <div class="col-auto" v-if="CART.IS_IMAGE_ADDING_ACTIVE == 1">
                                <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" :id="'add-image-notes-btn-' + BLOCK.ID" class="btn text-gray d-flex align-items-center popupwin" v-if="CART.IS_MEMBER_LOGGED_IN == 0">
                                    <i class="ti-picture"></i> <u>{#add_img#}</u>
                                </a>
                                <a href="#cart-page-panel" :id="'add-image-notes-btn-' + BLOCK.ID" data-toggle="drawer" class="btn text-gray d-flex align-items-center" @click="CART._showPanelType = 'image_notes'" v-else>
                                    <i class="ti-picture"></i> <u>{#add_img#}</u>
                                </a>
                            </div>
                            <div class="col-auto" v-if="CART.IS_CART_PRINTING_ACTIVE == 1">
                                <button :id="'print-btn-' + BLOCK.ID" class="btn text-gray d-flex align-items-center" @click="printSelection">
                                    <i class="ti-print"></i> <u>{#print#}</u>
                                </button>
                            </div>
                            <div class="col-auto" v-if="CART.IS_DELIVERY_DATE_ACTIVE == 1 || CART.IS_DELIVERY_HOUR_ACTIVE == 1">
                                <a href="#cart-page-panel" :id="'order-delivery-time-btn-' + BLOCK.ID" data-toggle="drawer" class="btn text-gray d-flex align-items-center" @click="CART._showPanelType = 'order_delivery_time'">
                                    <i class="ti-calendar"></i> <u>{#delivery_date#}</u>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="w-100 cart-campaign-list off-print mb-2" v-if="CART.CAMPAIGN_LIST.length > 0">
                    <div class="cart-block-title mb-1">{#cart_special_campaings#}</div>
                    <div class="row">
                        <div class="col-12 col-lg-6 mb-1" v-for="CMP in CART.CAMPAIGN_LIST">
                            <input type="checkbox" name="cart-campaign" class="form-control" 
                                    :value="CMP.ID" :checked="CMP.SELECTED == 1" :class="{ 'checked' : CMP.SELECTED == 1 }" :id="'campaign-input-' + CMP.ID" @change="setCampaign(CMP, $event)">
                            <label :for="'campaign-input-' + CMP.ID" class="w-100 h-100 fw-regular d-flex align-items-center border cart-campaign-item" :class="{'border-primary' : CMP.SELECTED == 1, 'border-light' : CMP.SELECTED != 1}">
                                <div class="col-camp-img" v-if="CMP.IMAGE != ''">
                                    <div class="image-wrapper">
                                        <figure class="image-inner">
                                            <img :src="CMP.IMAGE" class="border-round" :alt="CMP.TITLE">
                                        </figure>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="text-black campaign-title" v-html="CMP.TITLE"></div>
                                    <div class="text-gray campaign-description" v-html="CMP.DESCRIPTION"></div>
                                </div>
                                <div class="col-auto">
                                    <span class="input-checkbox border" :class="{'border-primary' : CMP.SELECTED == 1, 'border-light' : CMP.SELECTED != 1}">
                                        <i class="ti-check text-primary" v-if="CMP.SELECTED == 1"></i>
                                    </span>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>
                <!-- HOPI -->
                <div class="col-12 mb-2 off-print" v-if="CART.HOPI.status == 1 && CART.IS_DISCOUNT_COUPON_ACTIVE == 1">
                    <div class="row">
                        <div class="mb-1 text-body fw-bold list-title">{#hopi_campaings#}</div>
                    </div>
                    <div class="row" v-if="CART.HOPI && CART.HOPI.customer && CART.HOPI.customer.signedIn == null">
                        <a href="/srv/service/content-v5/sub-folder/30/1054/hopi" id="cart-hopi-add" data-width="768" class="fw-semibold text-body d-inline-flex align-items-center flex-wrap popupwin">
                            <img class="hopi-logo" src="/theme/standart/images/KrediKart/hopi-logo-v2-c.png" alt="hopi">
                            <span class="ml-1 btn btn-sm btn-light border border-light">
                                <b class="hopi-text">{#hopi#}</b>'{#hopi_click#}
                            </span>
                        </a>
                    </div>
                    <div class="row align-items-center" id="hopi-campaign-current" v-else>
                        <img class="hopi-logo" src="/theme/standart/images/KrediKart/hopi-logo-v2-c.png" alt="hopi">
                        <div id="hopi-campaign-current-wrap" class="ml-1">
                            <div id="hopi-campaign-current-name" v-if="CART.HOPI.customer.campaignCode == null">Seçilen Kampanya : <span class="fw-bold">{#ready_campaings#}</span></div>
                            <div id="hopi-campaign-current-name" v-else>Seçilen Kampanya : <span class="fw-bold">{{ CART.HOPI.customer.campaignName }}</span></div>
                            <div id="hopi-campaign-coin-balance" v-if="CART.HOPI.customer.coinAmount != null">
                                Kullanılan Paracık : <span class="fw-bold">{{ CART.HOPI.customer.coinAmount }}</span>
                            </div>
                            <div id="hopi-campaign-current-points" class="mt-1">
                                <a href="/srv/service/content-v5/sub-folder/30/1054/hopi" id="cart-hopi-change" data-width="768" class="btn btn-sm btn-primary border border-primary text-uppercase popupwin" id="hopi-campaign-current-change">{#change#}</a>
                                <a href="javascript:void(0)" id="hopi-campaign-current-remove" id="cart-hopi-remove" class="btn btn-sm btn-black border border-black text-uppercase ml-1" @click="hopiRemove()">{#remove#}</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- HOPI -->

                <!-- ZUBIZU -->
                <div class="col-12 mb-2 off-print" v-if="CART.ZUBIZU.status == 1 && CART.ZUBIZU.customer">
                    <div class="row">
                        <div class="mb-1 text-body fw-bold list-title">{#zubizu_campaings#}</div>
                    </div>
                    <div class="row" v-if="CART.ZUBIZU.customer.signedIn == 0">
                        <a href="/srv/service/content-v5/sub-folder/30/1054/zubizu" id="cart-zubizu-add" data-width="768" class="fw-semibold text-body d-inline-flex align-items-center flex-wrap popupwin">
                            <img class="zubizu-logo" src="/theme/standart/images/KrediKart/zubizu_icon.png" alt="zubizu">
                            <span class="ml-1 btn btn-sm btn-light border border-light">
                                <b class="zubizu-text">{#zubizu#}</b>'{#zubizu_click#}
                            </span>
                        </a>
                    </div>
                    <div class="row" v-else>
                        <a href="javascript:void(0)" @click="zubizuSignout()" id="cart-zubizu-remove" class="fw-semibold text-body d-inline-flex align-items-center flex-wrap">
                            <img class="zubizu-logo" src="/theme/standart/images/KrediKart/zubizu_icon.png" alt="zubizu">
                            <span class="ml-1 btn btn-sm btn-light border border-light">
                                <b class="zubizu-text">{#zubizu#}</b> {#zubizu_cancel#}
                            </span>
                        </a>
                    </div>
                </div>
                <!-- ZUBIZU -->
            </div>
            <div class="col-12 col-md-3 off-print">
                <div id="cart-price-container" class="w-100 bg-white position-sticky mb-1">
                    <a v-if="CART.IS_BUY_BUTTON_ACTIVE == 1 && !MOBILE" id="cart-buy-btn-top" href="/order" class="btn btn-primary w-100 text-uppercase text-center my-1">
                        {#buy#}
                    </a>
                    <div class="col-12 cart-price-container">
                        <div class="row">
                            <div class="col-12 py-1 border border-light border-round text-gray cart-price-box">
                                <div class="row mb-1">
                                    <div class="col-5 pr-0">{#cart_total#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.PRICE_CART) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                                <div class="row mb-1" v-if="CART.PRICE_PERSONALIZATION != 0">
                                    <div class="col-5 pr-0">{#personalization#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.PRICE_PERSONALIZATION) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                                <div class="row mb-1" v-if="CART.PRICE_GIFT_PACKAGE > 0">
                                    <div class="col-5 pr-0">{#gift_package#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.PRICE_GIFT_PACKAGE) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                                <div class="row mb-1" v-if="CART.PRICE_COUPON > 0">
                                    <div class="col-5 pr-0">{#coupon#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.PRICE_COUPON) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                                <div class="row mb-1" v-if="CART.PRICE_CAMPAIGN > 0">
                                    <div class="col-5 pr-0">{#campaing#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.PRICE_CAMPAIGN) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                                <div class="row mb-1" v-if="CART.DISPLAY_CARGO == 1">
                                    <div class="col-5 pr-0">{#cargo_price#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.PRICE_CARGO) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                                <div class="row mb-1" v-if="CART.HOPI.status == 1 && CART.HOPI.customer.signedIn == 1 && CART.HOPI.customer.coinBenefitDiscount > 0">
                                    <div class="col-5 pr-0">{#hopi_discount#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.HOPI.customer.coinBenefitDiscount) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                                <div class="row mb-1" v-if="CART.HOPI.status == 1 && (CART.HOPI.customer.campaignCode != null || CART.HOPI.customer.coinAmount > 0)">
                                    <div class="col-5 pr-0">{#hopi_coin#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.HOPI.customer.coinAmount) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                                <div class="row fw-bold text-primary">
                                    <div class="col-5 pr-0">{#general_price#}</div>
                                    <div class="col-1 p-0 text-center">:</div>
                                    <div class="col-6 pl-0 text-right">{{ format(CART.PRICE_GENERAL) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="w-100 cart-coupon-container mb-1" v-if="CART.IS_DISCOUNT_COUPON_ACTIVE == 1">
                    <div class="w-100 border border-light border-round">
                        <a href="#cart-page-panel" data-toggle="drawer" id="cart-coupon-code"
                           class="p-1 d-flex align-items-center justify-content-between text-body" 
                           @click="CART._showPanelType = 'coupon'">
                            <span>{#coupon_code#} {{ CART.COUPON_CODE != '' ? '{#edit#}' : '{#add#}' }}</span>
                            <i class="ti-arrow-right"></i>
                        </a>
                    </div>
                </div>
                <div class="w-100 cart-coupon-container mb-1" v-if="CART.IS_GENERAL_ORDER_NOTE_ACTIVE != 0">
                    <div class="w-100 border border-light border-round">
                        <a href="#cart-page-panel" data-toggle="drawer" id="cart-shopping-note"
                           class="p-1 d-flex align-items-center justify-content-between text-body"
                           @click="CART._showPanelType = 'general_order_note'">
                            <span>{#shopping_note#} {{ writeNote }}</span>
                            <i class="ti-arrow-right"></i>
                        </a>
                    </div>
                </div>
                <div class="w-100 cart-coupon-container mb-1" v-if="CART.HAS_GIFT == 1 && CART.IS_GENERAL_GIFT_PACKAGE == 1" v-for="(P, index) in CART.PRODUCTS">
                    <div class="w-100 border border-light border-round" v-if="P.CART_ID == 0">
                        <div class="gift-package-btn">
                            <input type="checkbox" 
                                name="HedPakDizi"
                                class="form-control" 
                                :id="'HedPakDizi' + P.CART_ID" 
                                :value="P.CART_ID" 
                                :checked="P.IS_GIFT_PACKAGE_ACTIVE == 1"
                                @change="giftPackage(index)">
                            <label :for="'HedPakDizi' + P.CART_ID" class="d-flex align-items-center p-1 m-0 fw-regular">
                                <span class="input-checkbox">
                                    <i class="ti-check"></i>
                                </span>
                                <span v-if="P.IS_GIFT_PACKAGE_ACTIVE == 1">{#gift_package_added#}</span>
                                <span v-if="P.IS_GIFT_PACKAGE_ACTIVE != 1">{#gift_package_add#}</span>
                                <span v-if="CART.GIFT_PACKAGE_COST > 0">+ {{ format(CART.GIFT_PACKAGE_COST) }} {{ CART.TARGET_CURRENCY }}</span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="w-100 cart-coupon-container mb-1" v-if="CART.HAS_GIFT == 1 && CART.IS_GENERAL_GIFT_PACKAGE == 1" v-for="(P, index) in CART.PRODUCTS">
                    <div class="w-100 border border-light border-round" v-if="P.CART_ID == 0">
                        <a href="#cart-page-panel" :id="'gift-btn' + P.CART_ID" data-toggle="drawer"
                            class="p-1 d-flex align-items-center justify-content-between text-body"
                            @click="CART._showPanelType = 'gift_package_note' + index">
                            <span>{{ P.GIFT_NOTES != '' ? ('{#edit#} (' + P.GIFT_NOTES.substr(0, 10) + '...)') : '{#gift_note#}' }}</span>
                            <i class="ti-arrow-right"></i>
                        </a>
                    </div>
                </div>
                <div class="col-12 payment-button-container bg-white">
                    <div class="row align-items-center">
                        <div class="col-5 d-block d-md-none">
                            <div class="w-100 d-flex align-items-center cart-price-btn" @click="goCartPrice('#cart-price-container')">
                                <div>
                                    <div class="small-text">{#general_price#}</div>
                                    <div class="fw-bold">{{ format(CART.PRICE_GENERAL) }} {{ CART.TARGET_CURRENCY }}</div>
                                </div>
                            </div>
                        </div>
                        <div class="col-7 col-md-12 p-0">
                            <a v-if="CART.IS_BUY_BUTTON_ACTIVE==1" href="/order" id="cart-buy-btn" class="btn btn-primary w-100 text-uppercase text-center">
                                {#buy#}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div data-rel="cart-page-panel" class="drawer-overlay off-print"></div>
        <div id="cart-page-panel" class="drawer-wrapper" data-display="overlay" data-position="right" data-callback="cartDrawerCallback">
            <div class="drawer-title">
                <span v-if="CART._showPanelType == 'coupon'">{#coupon_code#}</span>
                <span v-if="CART._showPanelType == 'general_order_note'">{#order_note#}</span>
                <span v-if="CART._showPanelType.indexOf('gift_package_note') > -1">{#gift_note#}</span>
                <span v-if="CART._showPanelType.indexOf('product_order_note') > -1">{#order_note#}</span>
                <span v-if="CART._showPanelType == 'order_delivery_time'">{#delivery_date#}</span>
                <span v-if="CART._showPanelType == 'image_notes'"></span>
                <div class="drawer-close">
                    <i class="ti-close"></i>
                </div>
            </div>
            <div class="clearfix drawer-body" v-if="CART._showPanelType == 'coupon'">
                <div class="w-100 mt-1">
                    <input type="text" class="form-control form-control-md mb-1" v-model="CART.COUPON_CODE">
                    <button v-if="!CART._hasCoupon" type="button" :id="'add-coupon-btn-' + BLOCK.ID" class="w-100 btn btn-primary text-uppercase" @click="addCoupon">{#actived#}</button>
                    <button v-else type="button" :id="'remove-coupon-btn-' + BLOCK.ID" class="w-100 btn btn-danger text-uppercase" @click="removeCoupon">{#cancel#}</button>
                </div>
            </div>
            <div class="clearfix drawer-body" v-if="CART._showPanelType == 'general_order_note'">
                <div class="w-100 mt-1">
                    <input type="text" class="form-control form-control-md mb-1" :id="'general-order-note-input-' + BLOCK.ID" v-model="CART.GENERAL_ORDER_NOTE">
                    <button type="button" :id="'general-order-note-savebtn-' + BLOCK.ID" class="w-100 btn btn-primary text-uppercase" @click="saveGeneralOrderNote">{#save#}</button>
                </div>
            </div>
            <div class="clearfix drawer-body" v-if="CART._showPanelType.indexOf('gift_package_note') > -1">
                <form action="/srv/service/cart/set-gift-notes/" class="w-100 mt-1 gift-package-note-form" ref="saveGiftNoteForm" @submit.prevent="saveGiftNote">
                    <p>{#character_limit#}: {{ GIFT_NOTE.GIFT_NOTES_LIMIT }}/<span>0</span></p>
                    <textarea class="form-control form-control-md mb-1" name="content" :id="'gift-note-textarea-' + BLOCK.ID" v-model="GIFT_NOTE.GIFT_NOTES"></textarea>
                    <button type="submit" :id="'gift-note-savebtn-' + BLOCK.ID" class="w-100 btn btn-primary text-uppercase">{#save#}</button>
                </form>
            </div>
            <div class="clearfix drawer-body" v-if="CART._showPanelType.indexOf('product_order_note') > -1">
                <form action="/srv/service/cart/set-order-notes/" class="w-100 mt-1 product-order-note-form" ref="saveProductOrderNoteForm" @submit.prevent="saveProductOrderNote">
                    <p>{#character_limit#}: {{ PRODUCT_ORDER_NOTE.ORDER_NOTES_LIMIT }}/<span>0</span></p>
                    <textarea class="form-control form-control-md mb-1" name="content" :id="'order-note-textarea-' + BLOCK.ID" v-model="PRODUCT_ORDER_NOTE.ORDER_NOTES"></textarea>
                    <button type="submit" :id="'order-note-savebtn-' + BLOCK.ID" class="w-100 btn btn-primary text-uppercase">{#save#}</button>
                </form>
            </div>
            <div class="clearfix drawer-body" v-if="CART._showPanelType == 'order_delivery_time'">
                <div class="block-title text-primary border-bottom border-light mb-1">{#delivery_date#}</div>
                <div class="w-100 mb-1" v-if="CART.IS_DELIVERY_DATE_ACTIVE == 1">
                    <p class="text-body">{{ CART.DELIVERY_DATE_TEXT }}</p>
                    <input type="text" class="form-control" :id="'delivery-date-datepicker-' + BLOCK.ID" ref="delivery_date_datepicker">
                </div>
                <div class="w-100 mt-1" v-if="CART.IS_DELIVERY_HOUR_ACTIVE == 1">
                    <p class="text-body">{{ CART.DELIVERY_HOUR_TEXT }}</p>
                    <select class="form-control" :id="'delivery-hour-datepicker-' + BLOCK.ID" ref="delivery_hour_datepicker" v-model="CART.DELIVERY_HOUR" @change="setCartDeliveryHour">
                        <option value=""></option>
                    </select>
                </div>
            </div>
            <form ref="saveImageNotesForm" enctype="multipart/form-data" method="post" @submit.prevent="saveImageNotes" autocomplete="off" class="clearfix drawer-body" v-if="CART._showPanelType == 'image_notes'">
                <input type="hidden" name="imageCount" value="1">
                <input type="hidden" name="fullname" :value="MEMBER.FIRST_NAME + ' ' + MEMBER.LAST_NAME">
                <input type="hidden" name="email" :value="MEMBER.MAIL">
                <div class="block-title text-primary border-bottom border-light mb-1">{#add_img#}</div>
                <div class="w-100 mb-1">
                    <div class="form-control bg-light d-flex align-items-center" v-html="MEMBER.FIRST_NAME + ' ' + MEMBER.LAST_NAME"></div>
                </div>
                <div class="w-100 mb-1">
                    <div class="form-control bg-light d-flex align-items-center" v-html="MEMBER.MAIL"></div>
                </div>
                <div class="w-100 mb-1">
                    <input type="file" id="image-notes-file" name="image1" class="form-control" ref="image_notes_file" accept="image/*">
                    <label for="image-notes-file" class="form-control form-control-md d-flex align-items-center justify-content-between text-content">
                        <span>{#select_img#}</span>
                        <i class="ti-picture text-primary"></i>
                    </label>
                </div>
                <div class="w-100 mb-1">
                    <textarea name="notes1" id="image-notes-file-note" class="form-control" placeholder="{#img_note#}"></textarea>
                </div>
                <div class="w-100 mb-1">
                    <button type="submit" id="image-notes-file-savebtn" class="w-100 btn btn-primary text-uppercase">{#save#}</button>
                </div>
            </form>
        </div>
    </div>
</div>