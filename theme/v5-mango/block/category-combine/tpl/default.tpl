<div class="col-12">
    {if $SETTING.DISPLAY_TITLE}
        <div class="block-title mb-1">
            {$BLOCK.TITLE}
        </div>
    {/if}
    <div id="combin-list-{$BLOCK.ID}" data-toggle="equalHeight" data-selector=".combine-detail-card" class="w-100 position-relative slider-block-wrapper mb-2">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                {foreach from=$COMBINE_LIST item=C}
                    <div class="swiper-slide mb-2 combine-item">
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
                                                    <div class="mr-1 discounted-price text-delete mb-10">{vat price=$C.PRICE_TOTAL_NOT_DISCOUNTED} {$CURRENCY}</div>
                                                {/if}
                                                <div class="current-price mb-10{if $C.PRICE_TOTAL_NOT_DISCOUNTED != $C.PRICE_TOTAL} text-primary{/if}">
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
            <div id="swiper-pagination-{$BLOCK.ID}" class="swiper-pagination bottom"></div>
        </div>
        <div id="swiper-prev-{$BLOCK.ID}" class="swiper-button-prev outside d-none d-md-flex"><i class="ti-arrow-left"></i></div>
        <div id="swiper-next-{$BLOCK.ID}" class="swiper-button-next outside d-none d-md-flex"><i class="ti-arrow-right"></i></div>
    </div>
</div>