<div class="col-12">
    <div class="col-12 p-0" data-toggle="equalHeight" data-selector=".combine-detail-card">
        <div class="row">
            {foreach from=$COMBINE_LIST item=C}
                <div
                    class="col-12 col-sm-6 col-md-4 mb-2 combine-item">
                    <div class="w-100 h-100 bg-white ease border border-round">
                        <div class="w-100 position-relative">
                            <a href="/{$C.URL}" class="image-wrapper">
                                <span class="image-inner">
                                    <img {if $IS_LAZY_LOAD_ACTIVE == '1'}src="{$LAZY_LOAD_LOADING_IMAGE}" data-src="{$C.IMAGE.SMALL}" class="lazyload" loading="lazy"{else}src="{$C.IMAGE.SMALL}"{/if} alt="{$C.NAME}">
                                </span>
                            </a>
                        </div>
                        <div class="col-12 py-1 combine-detail-card">
                            <div class="row">
                                <a href="/{$C.URL}" class="col-12 fw-semibold text-body">{$C.NAME}</a>
                                <div class="col-12 pt-1 pb-5 combine-bottom-line">
                                    <div class="row">
                                        <div class="col-12 text-gray combine-description mb-10 fs-12">{$C.DESCRIPTION|strip_tags}</div>
                                        <div class="col-12 product-price-wrapper d-flex flex-wrap">
                                            {if $C.PRICE_TOTAL_NOT_DISCOUNTED != $C.PRICE_TOTAL}
                                                <div class="mr-1 discounted-price text-delete mb-10">
                                                    {vat price=$C.PRICE_TOTAL_NOT_DISCOUNTED} {$CURRENCY}</div>
                                            {/if}
                                            <div
                                                class="current-price mb-10{if $C.PRICE_TOTAL_NOT_DISCOUNTED != $C.PRICE_TOTAL} text-primary{/if}">
                                                <strong class="fw-black">{vat price=$C.PRICE_TOTAL}</strong> {$CURRENCY}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
    {if $IS_PAGINATION_ACTIVE==1}
        <div class="col-12">
            <div class="col-12 bg-light p-1 mb-4 d-flex justify-content-center align-items-center pagination">{$PAGINATION}</div>
        </div>
    {/if}
</div>