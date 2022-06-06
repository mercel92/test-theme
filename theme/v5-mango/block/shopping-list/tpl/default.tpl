<div id="page-my-favourites" class="col-12" v-cloak>
    <div class="row">
        <div class="col-12 mb-1 pt-1 bg-white position-sticky page-title-wrapper">
            <div class="d-flex align-items-flex-start justify-content-between">
                <h1 class="d-flex align-items-center">
                    <i class="ti-heart-o ti-20px d-flex align-items-center justify-content-center text-white member-menu-icon"></i>
                    {#block_title#}
                </h1>
                <div class="d-flex align-items-center">
                    <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
                </div>
            </div>
            <div class="w-100 border-top border-secondary mt-1"></div>
        </div>
        <div class="col-12 favourites-list">
            <div class="row">
                <div class="col-12 mb-1 favourite-item" v-for="(CAT, ci) in DATA.CATEGORIES">
                    <div class="accordion-title p-1 fw-bold text-body bg-light border-round d-flex justify-content-between align-items-center" data-toggle="accordion">
                        <span>{{ CAT.NAME }}</span>
                        <span class="icon-wrapper text-primary">
                            <i class="ti-plus"></i>
                            <i class="ti-minus"></i>
                        </span>
                    </div>
                    <div class="accordion-body pt-1">
                        <div class="col-12 py-1 bg-light text-body" v-if="CAT.PRODUCTS.length < 1">{#no_result#}</div>
                        <div class="w-100" v-else>
                            <div class="col-12 mb-1 border border-light border-round order-item product-item variant-selection-container" v-for="(P, pi) in CAT.PRODUCTS">
                                <div class="row align-items-center">
                                    <div class="col-auto pr-0 py-1">
                                        <input type="checkbox" :id="'product-selection-' + P.ID + CAT.ID" :data-pid="P.ID" :data-category="CAT.ID" :data-list="P.LIST_ID" :class="'favourite-check' + CAT.ID" class="form-control favourite-check">
                                        <label :for="'product-selection-' + P.ID + CAT.ID">
                                            <span class="input-checkbox m-0">
                                                <i class="ti-check"></i>
                                            </span>
                                        </label>
                                    </div>
                                    <div class="col-2 col-lg-1 py-1">
                                        <a :href="'/' + P.URL" class="image-wrapper bg-light">
                                            <figure class="image-inner">
                                                <img :src="P.IMAGE.SMALL" :alt="P.TITLE">
                                            </figure>
                                        </a>
                                    </div>
                                    <div class="col-9 col-md">
                                        <div class="row align-items-center">
                                            <div class="col-12 py-1" v-bind:class="P.HAS_VARIANT ? 'col-lg-6' : ''">
                                                <a :href="'/' + P.BRAND_URL" target="_blank" class="d-block text-body fw-bold fav-product-brand" v-html="P.BRAND"></a>
                                                <a :href="'/' + P.URL" target="_blank" class="text-body fav-product-title" v-html="P.TITLE"></a>
                                            </div>
                                            <input type="hidden" :name="'subPro' + P.ID + CAT.ID" :id="'subPro' + P.ID + CAT.ID" :value="P.VARIANT_ID" />
                                            <input type="hidden" :id="'productCount' + P.ID + CAT.ID" :name="'productCount' + P.ID + CAT.ID">
                                            <div class="col-12 col-lg-6 pr-0 d-flex flex-wrap variant-wrapper" v-if="P.HAS_VARIANT">
                                                <div class="col-6 py-1 pl-0" v-if="P.VARIANT_FEATURE1_LIST.length > 0">
                                                    <div class="w-100 sub-one">
                                                        <select class="form-control form-control-md sub-select-item" data-group-id="1" data-toggle="variant">
                                                            <option value="0" :data-pid="P.ID" class="opt-title">{{ P.VARIANT_FEATURE1_TITLE }}</option>
                                                            <option :value="SUB.TYPE_ID"
                                                                    :data-id="SUB.TYPE_ID"
                                                                    :data-subproduct-id="SUB.ID"
                                                                    :data-pid="P.ID"
                                                                    :data-target="P.ID + CAT.ID"
                                                                    :data-type="SUB.TYPE"
                                                                    :data-code="SUB.CODE"
                                                                    :data-price="SUB.PRICE"
                                                                    :data-stock="SUB.STOCK"
                                                                    :data-barcode="SUB.BARCODE"
                                                                    :data-mop="SUB.MONEY_ORDER_PERCENT"
                                                                    :data-vat="SUB.VAT"
                                                                    :data-not-discounted="SUB.PRICE_NOT_DISCOUNTED"
                                                                    v-for="SUB in P.VARIANT_FEATURE1_LIST">
                                                                    {{ SUB.TYPE }}
                                                            </option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="col-6 py-1 pl-0" v-if="P.VARIANT_FEATURE2_LIST.length > 0">
                                                    <div class="w-100 sub-two">
                                                        <select class="form-control form-control-md sub-select-item" data-group-id="2" data-toggle="variant">
                                                            <option value="0" :data-pid="P.ID" class="opt-title">{{ P.VARIANT_FEATURE2_TITLE }}</option>
                                                            <option :value="SUB.TYPE_ID"
                                                                    :data-id="SUB.TYPE_ID"
                                                                    :data-subproduct-id="SUB.ID"
                                                                    :data-pid="P.ID"
                                                                    :data-target="P.ID + CAT.ID"
                                                                    :data-type="SUB.TYPE"
                                                                    :data-code="SUB.CODE"
                                                                    :data-price="SUB.PRICE"
                                                                    :data-stock="SUB.STOCK"
                                                                    :data-barcode="SUB.BARCODE"
                                                                    :data-mop="SUB.MONEY_ORDER_PERCENT"
                                                                    :data-vat="SUB.VAT"
                                                                    :data-not-discounted="SUB.PRICE_NOT_DISCOUNTED"
                                                                    v-for="SUB in P.VARIANT_FEATURE2_LIST">
                                                                    {{ SUB.TYPE }}
                                                            </option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-2 py-1 fw-bold text-primary"><span class="product-price price-current">{{ vat(P.PRICE_SELL, P.VAT) }}</span> {{ P.TARGET_CURRENCY }}</div>
                                    <div class="col-auto py-1 d-none justify-content-flex-end d-md-flex">
                                        <a href="javascript:void(0);" class="text-body remove-product-btn" @click="remove(CAT.ID, P.ID)"><i class="ti-trash-o"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="row favlist-share-btns" v-if="DATA.IS_SHARE == 0 && CAT.PRODUCTS.length > 0">
                                <div class="col-6 col-sm-auto mb-1">
                                    <a href="javascript:void(0);" class="btn btn-sm btn-primary border border-primary w-100" @click="addSelection(CAT.ID)">
                                        <i class="ti-basket"></i>
                                        <span class="fw-semibold">{#add_to_selected#}</span>
                                    </a>
                                </div>
                                <div class="col-6 col-sm-auto mb-1">
                                    <a href="javascript:void(0);" class="btn btn-sm btn-light border border-secondary w-100" @click="remove(CAT)">
                                        <i class="ti-trash-o"></i>
                                        <span class="fw-semibold">{#remove_to_selected#}</span>
                                    </a>
                                </div>
                                <div class="col-6 col-sm-auto mb-1">
                                    <a href="javascript:void(0);" class="btn btn-sm btn-light border border-secondary w-100" @click="printSelection()">
                                        <i class="ti-print"></i>
                                        <span class="fw-semibold">{#print#}</span>
                                    </a>
                                </div>
                                <div class="col-6 col-sm-auto mb-1">
                                    <a :href="'/srv/service/content-v5/sub-folder/' + BLOCK.PAGE_ID + '/' + BLOCK.PARENT_ID + '/share/' + ci" class="btn btn-sm btn-light border border-secondary popupwin w-100">
                                        <i class="ti-share"></i>
                                        <span class="fw-semibold">{#share#}</span>
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