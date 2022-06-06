<div id="page-my-stock-alarms" class="col-12" v-cloak>
    <div class="row" v-if="!LOADING">
        <div class="col-12 mb-1">
            <div class="d-flex align-items-flex-start justify-content-between">
                <h1 class="d-flex align-items-center">
                    <i class="ti-bell ti-20px text-white member-menu-icon d-flex align-items-center justify-content-center"></i>
                    {#block_title#}
                </h1>
                <a href="javascript:void(0);" onclick="window.history.back();" class="btn btn-light border border-light text-uppercase"><i class="ti-arrow-left"></i> {#back#}</a>
            </div>
            <div class="w-100 border-top mt-1"></div>
        </div>
        <div class="col-12 stock-alarm-list" v-if="DATA.PRODUCTS.length > 0">
            <div class="col-12 mb-1 border border-light border-round stock-alarm-item">
                <div class="row align-items-center" v-for="(PRODUCT, index) in DATA.PRODUCTS">
                    <div class="col-auto pr-0 checkbox-width">
                        <input type="checkbox" :id="'stock-alarm-' + index" class="form-control stock-alarms-input" :data-alarm="PRODUCT.ALARM_ID" :data-id="PRODUCT.ID"
                                :data-variant="PRODUCT.VARIANT_ID">
                        <label :for="'stock-alarm-' + index">
                            <div class="input-checkbox">
                                <i class="ti-check"></i>
                            </div>
                        </label>
                    </div>
                    <div class="col-10 col-md py-1">
                        <a :href="`/` + PRODUCT.URL" class="text-body"><strong>{{ PRODUCT.TITLE }}</strong></a>
                        <span class="d-block" v-if="PRODUCT.VARIANT_NAME">{{ PRODUCT.VARIANT_NAME }}</span>
                    </div>
                    <div class="col-6 col-md py-1">
                        <div class="fw-medium mb-10">{#stock#}</div>
                        <div><strong>{{ PRODUCT.STOCK }}</strong></div>
                    </div>
                    <div class="col-6 col-md py-1">
                        <div class="fw-medium mb-10">{#price_sell#}</div>
                        <div><strong>{{ price(PRODUCT.PRICE_SELL) }}</strong> {{ PRODUCT.TARGET_CURRENCY }}</div>
                    </div>
                    <div class="col-6 col-md py-1">
                        <div class="fw-medium mb-10">{#add_date#}</div>
                        <div><strong>{{ PRODUCT.DATE }}</strong></div>
                    </div>
                    <div class="col-6 col-lg">
                        <div class="row align-items-center">
                            <div class="col-auto col-lg py-1">
                                <input type="hidden" :id="'ProductCount' + PRODUCT.ID" :name="'ProductCount' + PRODUCT.ID" value="1">
                                <a href="javascript:void(0);" @click="addToCart(PRODUCT.ID, PRODUCT.VARIANT_ID, 1)"
                                    class="btn btn-primary fw-bold stock-alarm-add-btn d-flex justify-content-center"><i class="ti-basket"></i>{#add#}</a>
                            </div>
                            <div class="col-auto pl-0">
                                <a href="javascript:void(0);" class="stock-alarm-delete-btn text-body d-flex align-items-center justify-content-center" @click="remove(PRODUCT.ALARM_ID)">
                                    <i class="ti-trash-o"></i>
                                    <span class="d-block d-lg-none ml-1">{#remove#}</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-1">
                    <a href="javascript:void(0);" class="btn btn-primary w-100" @click="addToCart()"><i class="ti-basket"></i> {#add_selected#}</a>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-1">
                    <a href="javascript:void(0);" class="btn btn-light border border-light w-100" @click="remove()">
                        <i class="ti-trash-o"></i> {#delete_selected#}
                    </a>
                </div>
            </div>
        </div>
        <div class="col-12" v-else>
            <div class="col-12 p-1 border border-round">
                {#no_result#}
            </div>
        </div>
    </div>
</div>