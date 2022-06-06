<div id="page-collect-product" class="w-100" v-cloak>
    <div class="col-12 mb-2">
        <div class="w-100 mb-1 block-title" v-if="SETTING.DISPLAY_TITLE == 1">{#block_title#}</div>
        <div class="w-100" v-if="SETTING.INFO != ''" v-html="SETTING.INFO"></div>
    </div>
    <div class="col-12 mb-2 collect-container">
        <div class="col-12 d-none d-md-block collect-table-head bg-light mb-1">
            <div class="row">
                <div class="col-2 py-1 text-uppercase fw-bold">{#type#}</div>
                <div class="col-1 py-1 text-uppercase fw-bold"></div>
                <div class="col-5 py-1 text-uppercase fw-bold">{#product#}</div>
                <div class="col-1 py-1 text-uppercase fw-bold text-center">{#detail#}</div>
                <div class="col-3 py-1 text-uppercase fw-bold">{#price#}</div>
            </div>
        </div>
        <div class="col-12 border border-right-0 border-light border-round collect-table-body">
            <div class="row">
                <div class="col-12 collect-item product-item" v-for="(C, ci) in DATA">
                    <div class="row">
                        <div class="col-12 col-md-2 py-1 d-flex align-items-center border-right border-bottom border-light text-uppercase fw-bold">{{ C.NAME }}</div>
                        <div class="col-2 col-md-1 py-1 d-flex align-items-center border-right border-bottom border-light">
                            <div class="image-wrapper">
                                <span class="image-inner" v-if="C.PRODUCT">
                                    <img :src="C.PRODUCT.IMAGE.SMALL" :alt="C.NAME">
                                </span>
                            </div>
                        </div>
                        <div class="col-10 col-md-5 py-1 d-flex align-items-center border-right border-bottom border-light dropdown">
                            <div class="w-100 h-100 d-flex flex-wrap align-items-center fw-bold ti-arrow-down collect-title dropdown-title" :id="'product' + C.PRODUCT.ID"
                            data-toggle="dropdown" data-callback="collectChange" v-if="C.PRODUCT">
                                <div class="w-100">
                                    <div class="brand-title fw-bold text-body" v-if="C.PRODUCT.BRAND != ''">{{ C.PRODUCT.BRAND }}</div>
                                    <div class="product-title fw-regular text-gray">{{ C.PRODUCT.TITLE }}</div>
                                </div>
                            </div>
                            <div class="w-100 h-100 d-flex align-items-center fw-bold ti-arrow-down dropdown-title" :id="'product-select' + C.ID"
                            data-toggle="dropdown" data-callback="collectChange" v-else>
                                {#choose_product#}
                            </div>
                            <div class="w-100 p-0 border-0 dropdown-menu">
                                <div class="d-flex align-items-center border-bottom border-light py-1 cursor-pointer" :id="'list' + P.ID" :data-pid="P.ID" :data-id="pi" :data-catid="ci" v-for="(P, pi) in C.PRODUCTS">
                                    <div class="col-2" disabled>
                                        <div class="image-wrapper">
                                            <span class="image-inner">
                                                <img :src="P.IMAGE.SMALL" :alt="P.TITLE + ' - ' + P.BRAND">
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-10 pl-0" disabled>
                                        <div class="brand-title fw-bold text-body" v-if="P.BRAND != ''">{{ P.BRAND }}</div>
                                        <div class="product-title fw-regular text-gray">{{ P.TITLE }}</div>
                                    </div>
                                    <input type="hidden" :name="'subPro'+ P.ID" :id="'subPro'+ P.ID" value="0" />
                                </div>
                            </div>
                        </div>
                        <div class="col-2 col-md-1 py-1 d-flex align-items-center border-right border-bottom border-light justify-content-center">
                            <a class="text-primary collect-link" target="_blank" :id="'link' + C.PRODUCT.ID" :href="'/' + C.PRODUCT.URL" v-if="C.PRODUCT">
                                <i class="ti-zoom-in"></i>
                            </a>
                            <a class="text-primary collect-link" href="javascript:void(0)" :id="'link' + C.ID" @click="empty()" v-else>
                                <i class="ti-zoom-in"></i>
                            </a>
                        </div>
                        <div class="col-10 col-md-3 py-1 d-flex align-items-center flex-wrap border-right border-bottom border-light">
                            <div class="w-100 collect-variants" v-if="C.PRODUCT && C.PRODUCT.HAS_VARIANT">
                                <div class="col-12 pr-0 variant-wrapper" :class="'variant-wrapper-' + C.PRODUCT.ID">
                                    <div class="row">
                                        <div class="col-6 pl-0 pb-1" v-if="C.PRODUCT.VARIANT_FEATURE1_LIST.length > 0">
                                            <div class="w-100 sub-one">
                                                <select class="form-control form-control-md mb-1 sub-select-item" data-group-id="1" data-toggle="variant" @change="collectVariant">
                                                    <option value="0" :data-pid="C.PRODUCT.ID" class="opt-title">{{ C.PRODUCT.VARIANT_FEATURE1_TITLE }}</option>
                                                    <option :value="SUB.TYPE_ID"
                                                            :data-id="SUB.TYPE_ID"
                                                            :data-subproduct-id="SUB.ID"
                                                            :data-pid="C.PRODUCT.ID"
                                                            :data-target="C.PRODUCT.ID"
                                                            :data-type="SUB.TYPE"
                                                            :data-code="SUB.CODE"
                                                            :data-price="SUB.PRICE"
                                                            :data-stock="SUB.STOCK"
                                                            :data-barcode="SUB.BARCODE"
                                                            :data-mop="SUB.MONEY_ORDER_PERCENT"
                                                            :data-vat="SUB.VAT"
                                                            :data-not-discounted="SUB.PRICE_NOT_DISCOUNTED"
                                                            v-for="SUB in C.PRODUCT.VARIANT_FEATURE1_LIST">
                                                            {{ SUB.TYPE }}
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-6 pl-0 pb-1" v-if="C.PRODUCT.VARIANT_FEATURE2_LIST.length > 0">
                                            <div class="w-100 sub-two">
                                                <select class="form-control form-control-md mb-1 sub-select-item" data-group-id="2" data-toggle="variant" @change="collectVariant">
                                                    <option value="0" :data-pid="C.PRODUCT.ID" class="opt-title">{{ C.PRODUCT.VARIANT_FEATURE2_TITLE }}</option>
                                                    <option :value="SUB.TYPE_ID"
                                                            :data-id="SUB.TYPE_ID"
                                                            :data-subproduct-id="SUB.ID"
                                                            :data-pid="C.PRODUCT.ID"
                                                            :data-target="C.PRODUCT.ID"
                                                            :data-type="SUB.TYPE"
                                                            :data-code="SUB.CODE"
                                                            :data-price="SUB.PRICE"
                                                            :data-stock="SUB.STOCK"
                                                            :data-barcode="SUB.BARCODE"
                                                            :data-mop="SUB.MONEY_ORDER_PERCENT"
                                                            :data-vat="SUB.VAT"
                                                            :data-not-discounted="SUB.PRICE_NOT_DISCOUNTED"
                                                            v-for="SUB in C.PRODUCT.VARIANT_FEATURE2_LIST">
                                                            {{ SUB.TYPE }}
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="w-100 d-flex align-items-center justify-content-between">
                                <div class="current-price">
                                    <strong class="product-price" :id="C.PRODUCT ? 'product-price' + C.PRODUCT.ID : ''">
                                        {{ C.PRODUCT ? vat(C.PRODUCT.PRICE_SELL, C.PRODUCT.VAT) : '0,00' }}
                                    </strong> {{ C.PRODUCT ? C.PRODUCT.TARGET_CURRENCY : CURRENCY }}
                                </div>
                                <div class="qty collect-qty ml-auto" data-toggle="qty" data-callback="collectQty">
                                    <span class="ti-minus"></span>
                                    <span class="ti-plus"></span>
                                    <input type="number" class="form-control no-arrows text-center" :id="C.PRODUCT ? 'pro-qty' + C.PRODUCT.ID : ''"
                                    :value="C.PRODUCT ? C.PRODUCT.MIN_ORDER_COUNT : '1'">
                                </div>
                                <button class="btn btn-outline-primary collect-add" title="Sepete Ekle" :id="'addBtn' + (C.PRODUCT ? C.PRODUCT.ID : C.ID)"
                                @click="C.PRODUCT ? add(C.PRODUCT.ID, C.PRODUCT.HAS_VARIANT) : empty()">
                                    <i class="ti-basket"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 d-flex flex-wrap justify-content-between border-right border-light">
                    <div class="col-6 col-md-4 col-lg-2 p-1 pl-0">
                        <div class="text-uppercase fw-bold">{#total#}</div>
                        <div><span id="collect-total-length">0</span> {#product#}</div>
                    </div>
                    <div class="col-6 col-md-4 col-lg-2 border-left border-light p-1">
                        <div class="text-uppercase fw-bold">{#total#} {#amount#}</div>
                        <div><strong class="fw-black" id="collect-total-price">0,00</strong> {{ CURRENCY }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 collect-buttons d-flex align-items-start flex-wrap mb-1">
        <a href="javascript:void(0);" id="collect-add-fav" class="btn btn-light border fw-semibold mr-1 mb-1" @click="addFav()"><i class="ti-heart-o"></i> {#add_favorites#}</a>
        <a href="javascript:void(0);" id="collect-print" class="btn btn-light border fw-semibold mr-1 mb-1" onclick="window.print()"><i class="ti-print"></i> {#print#}</a>
        <div class="btn btn-light border fw-semibold mr-1 mb-1 p-0 dropdown">
            <div class="dropdown-title" id="collect-share-btns" data-toggle="dropdown"><i class="ti-share"></i> {#share#}</div>
            <div class="dropdown-menu share-buttons pb-0">
                <div class="row align-items-center">
                    <div class="pl-1 pb-1">
                        <a id="collect-facebook" :href="'https://www.facebook.com/sharer/sharer.php?u=' + pathURL" class="border border-round facebook" target="_blank"><i class="ti-facebook"></i></a>
                    </div>
                    <div class="pl-1 pb-1">
                        <a id="collect-twitter" :href="'https://twitter.com/share?url=' + pathURL + '&text={#block_title#}'" class="border border-round twitter" target="_blank"><i class="ti-twitter"></i></a>
                    </div>
                    <div class="pl-1 pb-1">
                        <a id="collect-linkedin" :href="'http://www.linkedin.com/shareArticle?url=' + pathURL" class="border border-round linkedin" target="_blank"><i class="ti-linkedin"></i></a>
                    </div>
                    <div class="pl-1 pb-1">
                        <a id="collect-reddit" :href="'http://reddit.com/submit?url=' + pathURL + '&title={#block_title#}'" class="border border-round reddit" target="_blank"><i class="ti-reddit"></i></a>
                    </div>
                    <div class="pl-1 pb-1">
                        <a id="collect-whatsapp" :href="'https://wa.me/?text=' + pathURL + ' - {#block_title#}'" class="border border-round whatsapp" target="_blank"><i class="ti-whatsapp"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <a href="javascript:void(0);" class="ml-auto col-12 col-sm-4 col-lg-2 btn btn-primary mb-1 collect-all-add-cart-btn" id="collect-all-add-cart-btn" @click="selectAllAdd()"><i class="ti-basket"></i> {#buy_now#}</a>
    </div>
</div>

