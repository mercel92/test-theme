<div class="col-12 d-flex align-items-center justify-content-center my-2">
    <div class="col-12 col-lg-8 col-md-10 col-sm-12 p-2 border border-light border-round">
        {if $ORDER_FOUND == 0}
            <div class="w-100 mb-2 text-uppercase d-flex align-items-center fw-bold order-blok-title">
                <i class="ti-box mr-1"></i> {#block_title#}
            </div>
            <form action="/{url type='page' id='92'}" id="order-tracking-form-{$BLOCK.ID}" method="GET" class="w-100" autocomplete="off" novalidate>
                <input type="hidden" name="type" id="order-tracking-type-{$BLOCK.ID}" value="email">
                {if $PHONE_ACTIVE == '1'}
                    <ul id="order-tracking-tab-{$BLOCK.ID}" class="w-100 tab-nav border-bottom list-style-none">
                        <li data-type="email" class="active"><a href="#order-tracking" data-toggle="tab" class="d-block fw-bold text-uppercase position-relative">{#with_email#}</a></li>
                        <li data-type="phone" ><a href="#order-with-phone" data-toggle="tab" class="d-block fw-bold text-uppercase position-relative">{#with_phone#}</a></li>
                    </ul>
                {/if}
                <div class="row mt-1">
                    <div class="col-12 col-sm-6 col-md-5 mb-1">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="text" id="order-no-{$BLOCK.ID}" name="order" class="form-control form-control-md" placeholder="{#order_number#}:" data-toggle="placeholder" data-validate="required"> 
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 col-md-5 mb-1 tab-content">
                        <div id="order-tracking" class="w-100 tab-pane active">
                            <div class="w-100 popover-wrapper position-relative">
                                <input type="email" id="order-email-{$BLOCK.ID}" name="email" class="form-control form-control-md" placeholder="{#enter_mail#}" data-toggle="placeholder" {if $PHONE_ACTIVE != '1'}data-validate="required,email" {/if}> 
                            </div>
                        </div> 
                        {if $PHONE_ACTIVE == '1'}
                            <div id="order-with-phone" class="w-100 tab-pane">
                                <div class="w-100 popover-wrapper position-relative">
                                    <input type="tel" id="order-phone-{$BLOCK.ID}" name="phone" class="form-control form-control-md" placeholder="{#enter_phone_number#}" data-toggle="placeholder" data-flag-masked>
                                </div>
                            </div>
                        {/if}
                    </div>
                    <div class="col-12 col-md-2">
                        <button type="submit" class="btn btn-dark w-100 text-uppercase">{#search#}</button>
                    </div>
                </div>
            </form>
        {/if}
        {if $ORDER_FOUND == -1}
            <div class="d-flex align-items-center justify-content-between fw-bold">
                {#no_result_info#} <a href="/{url type='page' id='92'}" class="btn btn-light border border-light order-back-btn"><i class="ti-arrow-left"></i> {#back#}</a>
            </div>
        {/if}
        {if $ORDER_FOUND == 1}
            <div class="d-flex align-items-flex-start justify-content-between mb-2">
                <div class="text-uppercase d-flex align-items-center fw-bold order-blok-title">
                    <i class="ti-basket-o"></i>
                    <span> {#order_status#} <small class="d-block text-content text-gray">{#order_number#}: {$ORDER.order_number}</small></span>
                </div>
                <a href="/{url type='page' id='92'}" class="btn btn-light border border-light text-uppercase order-back-btn"><i class="ti-arrow-left"></i> {#back#}</a>
            </div>
            <ul class="w-100 d-flex mb-2 border-bottom tab-nav list-style-none">
                <li class="active d-flex"><a class="d-block fw-bold text-uppercase position-relative" href="#order-status-{$BLOCK.ID}" data-toggle="tab">{#status#}</a></li>
                <li class="d-flex"><a class="d-block fw-bold text-uppercase position-relative" href="#order-detail-{$BLOCK.ID}" data-toggle="tab">{#details#}</a></li>
            </ul>
            <div class="w-100 tab-content">
                <nav class="w-100 pt-1 order-process mb-2">
                    <ul class="w-100 clearfix">
                        <li class="w-25 px-1 d-flex align-items-center position-relative border-bottom border-success text-content passed">
                            <i class="ti-basket"></i>
                            <span> {#order_buy#}
                            <small class="d-block">{$ORDER.create_date}</small>
                            </span>
                            <em class="process-dot border-circle position-absolute"></em>
                        </li>
                        <li class="w-25 px-1 d-flex align-items-center position-relative border-bottom text-content {if $ORDER.order_status > 2}border-success passed{else}border-light{/if}">
                            <i class="ti-clipboard"></i>
                            <span> {#order_get_ready#}</span>
                            <em class="process-dot border-circle position-absolute"></em>
                        </li>
                        <li class="w-25 px-1 d-flex align-items-center position-relative border-bottom text-content {if $ORDER.order_status > 5}border-success passed{else}border-light{/if}">
                            <i class="ti-truck-o"></i>
                            <span> {#cargo_given#}</span>
                            <em class="process-dot border-circle position-absolute"></em>
                        </li>
                        <li class="w-25 px-1 d-flex align-items-center position-relative border-bottom text-content {if $ORDER.order_status > 7}border-success passed{else}border-light{/if}">
                            <i class="ti-box"></i>
                            <span>{#order_delivered#}</span>
                            <em class="process-dot border-circle position-absolute"></em>
                        </li>
                    </ul>
                </nav>
                <div id="order-status-{$BLOCK.ID}" class="w-100 tab-pane active">
                    <div class="col-12 py-1 bg-light d-block d-md-flex align-items-center justify-content-between">
                        <div class="d-block d-md-flex align-items-center text-content fw-bold  mb-1 mb-md-0">
                            {if $CARGO.IMAGE1.URL != ''}
                                <img src="{$CARGO.IMAGE1.URL}" alt="{$CARGO.NAME}" class="d-block mr-1"/>
                            {/if}
                            <span class="text-primary">{$ORDER.cargo_company_name}</span>&nbsp;- {#cargo_number#} :&nbsp;<span class="text-gray">{$ORDER.cargo_number}</span>
                        </div>
                        {if $ORDER.CARGO_TRACKING_URL != null}
                            <a href="#" class="text-uppercase text-content text-primary fw-bold">{#follow#}</a>
                        {/if}
                    </div>
                </div>
                <div id="order-detail-{$BLOCK.ID}" class="w-100 tab-pane">
                    <div class="row mb-1 address-detail">
                        <div class="col-12 col-md-6 py-1 address-item">
                            <div class="w-100 h-100 border border-light border-round">
                                <div class="p-1 address-title border-bottom border-light fw-bold">{#cargo_info#}</div>
                                <div class="p-1 address-body text-content">
                                    <div class="row mb-1">
                                        <div class="col-5 fw-bold pr-0">{#payment_method#}</div>
                                        <div class="col-7">{$ORDER.payment_method}</div>
                                    </div>
                                    <div class="row mb-1">
                                        <div class="col-5 fw-bold pr-0">{#cargo_company#}</div>
                                        <div class="col-7">{$ORDER.cargo_company_name}</div>
                                    </div>
                                    <div class="row mb-1">
                                        <div class="col-5 fw-bold pr-0">{#cargo_number#}</div>
                                        <div class="col-7">{$ORDER.cargo_number}</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-5 fw-bold pr-0">{#buyer#}</div>
                                        <div class="col-7">{$ORDER_ADDRESS.first_name} {$ORDER_ADDRESS.last_name}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 py-1 address-item">
                            <div class="w-100 h-100 border border-light border-round">
                                <div class="p-1 address-title border-bottom border-light fw-bold">{#delivery_adress#}</div>
                                <div class="p-1 address-body text-content">
                                    <p>{$ORDER_ADDRESS.address} {$ORDER_ADDRESS.town} / {$ORDER_ADDRESS.city}</p>
                                    <p class="mb-0">{$ORDER_ADDRESS.customer_phone}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="w-100 order-product-list">
                        <h6>{#products#}</h6>
                        <nav class="product-list border border-light border-round mb-1">
                            <ul class="clearfix">
                            {foreach from=$PRODUCTS item=P name=product}
                                <li class="w-100 p-1 {if !$smarty.foreach.product.last}border-bottom border-light{/if}">
                                    <div class="row">
                                        <div class="col-3 col-md-2">
                                            <div class="image-wrapper">
                                                <figure class="image-inner">
                                                    <img src="/Data/K/{$P.image}" alt="{$P.product_name}">
                                                </figure>
                                            </div>
                                        </div>
                                        <div class="col-9 col-md-5">
                                            <div class="text-body fw-bold">{$P.brand}</div>
                                            <div class="text-gray product-title">{$P.product_name}</div>
                                        </div>
                                        <div class="col-6 col-md-2 text-body product-unit text-md-center">
                                            <p class="fw-bold">{#count#}</p>
                                            <div>{$P.count}</div>
                                        </div>
                                        <div class="col-6 col-md-3 product-total-price text-right text-md-left">
                                            <p class="fw-bold">{#sale_price#}</p>
                                            <div>{format price=$P.total_sale_price} {$P.sale_currency}</div>
                                        </div>
                                    </div>
                                </li>
                                {/foreach}
                            </ul>
                        </nav>
                        <div class="d-flex align-items-center justify-content-between">
                            <div class="fw-bold">{#total#}</div>
                            <div class="fw-bold">{$ORDER.order_total} {$ORDER.order_currency}</div>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    </div>
</div>
