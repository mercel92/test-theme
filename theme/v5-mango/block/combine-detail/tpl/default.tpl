<div class="col-12">
    <div class="row mb-2">
        <div id="combine-left" class="col-12 col-md-6 py-1">
            <div id="combine-detail-images-wrapper-{$BLOCK.ID}" class="w-100 position-relative combine-detail-images-wrapper mb-2">
                <div class="w-100 position-relative mb-1 combine-detail-images">
                    <div id="combine-detail-slider-{$BLOCK.ID}" class="swiper-container bg-light">
                        <div class="swiper-wrapper" id="gallery-{$BLOCK.ID}">
                            {foreach from=$COMBINE.IMAGE_LIST item=IMAGE name=image}
                                <a class="swiper-slide" href="{$IMAGE.BIG}">
                                    <div class="image-wrapper">
                                        <figure class="image-inner">
                                            <img src="{$IMAGE.BIG}" alt="{$COMBINE.NAME} - {$smarty.foreach.image.iteration}">
                                        </figure>
                                    </div>
                                </a>
                            {/foreach}
                        </div>
                    </div>
                    <div id="swiper-pagination-{$BLOCK.ID}" class="swiper-pagination bottom"></div>
                    <div id="swiper-prev-{$BLOCK.ID}" class="swiper-button-prev"><i class="ti-arrow-left"></i></div>
                    <div id="swiper-next-{$BLOCK.ID}" class="swiper-button-next"><i class="ti-arrow-right"></i></div>
                </div>
                {if $COMBINE.IMAGE_LIST|count > 1}
                    <div class="col-12 position-relative combine-thumb-slider-wrapper d-none">
                        <div id="combine-thumb-slider-{$BLOCK.ID}" class="swiper-container">
                            <div class="swiper-wrapper">
                                {foreach from=$COMBINE.IMAGE_LIST item=IMAGE name=image}
                                    <div class="swiper-slide w-25 bg-light">
                                        <div class="image-wrapper">
                                            <figure class="image-inner">
                                                <img src="{$IMAGE.SMALL}" alt="{$COMBINE.NAME} - {$smarty.foreach.image.iteration}">
                                            </figure>
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                        <div id="swiper-thumb-prev-{$BLOCK.ID}" class="swiper-button-prev"><i class="ti-arrow-left"></i></div>
                        <div id="swiper-thumb-next-{$BLOCK.ID}" class="swiper-button-next"><i class="ti-arrow-right"></i></div>
                    </div>
                {/if}
            </div>
            <h1 class="block-title no-line">{$COMBINE.NAME}</h1>
            {if $COMBINE.DESCRIPTION}
                <div class="text-gray mb-2">
                    {$COMBINE.DESCRIPTION|strip_tags}
                </div>
            {/if}
            <div class="product-price-wrapper d-flex flex-wrap">
                <div class="fw-semibold text-body mr-1">{#combine_price#} :</div>
                {if $COMBINE.PRICE_TOTAL_NOT_DISCOUNTED != $COMBINE.PRICE_TOTAL}
                    <div class="mr-1 discounted-price text-delete">{vat price=$COMBINE.PRICE_TOTAL_NOT_DISCOUNTED} {$CURRENCY}</div>
                {/if}
                <div class="current-price{if $COMBINE.PRICE_TOTAL_NOT_DISCOUNTED != $COMBINE.PRICE_TOTAL} text-primary{/if}">
                    <strong class="fw-black">{vat price=$COMBINE.PRICE_TOTAL}</strong> {$CURRENCY}
                </div>
            </div>
        </div>
        <div id="product-right" class="col-12 col-md-6 py-1">
            <div class="block-title mb-1">
                {#combine_products#}
            </div>
            <div class="w-100 combine-product-list">
                {foreach from=$COMBINE.PRODUCTS item=P key=index}
                    <div class="col-12 border mb-10 combine-product-item product-item" id="combine-product-item-{$P.ID}{$BLOCK.ID}">
                        <div class="row align-items-center">
                            <div class="col-3 col-lg-2 d-flex align-items-center py-1 pr-0">
                                <input type="checkbox" id="combine-select-input-{$P.ID}{$BLOCK.ID}" data-target="{$P.ID}" data-name="{$P.TITLE}" class="form-control combine-select-input">
                                <label for="combine-select-input-{$P.ID}{$BLOCK.ID}" class="m-0">
                                    <span class="input-checkbox">
                                        <i class="ti-check"></i>
                                    </span>
                                </label>
                                <div class="combine-product-image">
                                    <a href="/{$P.URL}" class="image-wrapper">
                                        <span class="image-inner">
                                            <img src="{$P.IMAGE.SMALL}" alt="{$P.TITLE} - {$P.BRAND}">
                                        </span>
                                    </a>
                                </div>
                            </div>
                            <div class="col-6 col-lg-4 py-1 pr-0">
                                {if $DISPLAY_BRAND == 1 && $P.BRAND != ''}
                                    <div class="mb-5">
                                        <a href="/{$P.BRAND_URL}" class="text-body fw-bold">{$P.BRAND}</a>
                                    </div>
                                {/if}
                                <a href="/{$P.URL}" class="text-gray fs-12">{$P.TITLE}</a>
                            </div>
                            <div class="col-3 col-lg-3 py-1 pr-0">
                                <div class="product-price-wrapper d-flex flex-wrap">
                                    {if $P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1}
                                        <div class="mr-1 product-discounted-price text-delete fs-12 {if $P.DISCOUNT_PERCENT <= 0}d-none{/if}">
                                            <span class="product-price-not-discounted">{vat price=$P.PRICE_NOT_DISCOUNTED vat=$P.VAT}</span> {$P.TARGET_CURRENCY}
                                        </div>
                                    {/if}
                                    {if $P.DISPLAY_VAT === "1"}
                                        <div class="current-price" id="current-price{$P.ID}{$BLOCK.ID}">
                                            <strong class="fw-black product-price">{vat price=$P.PRICE_SELL vat=$P.VAT}</strong>
                                            {$P.TARGET_CURRENCY}
                                        </div>
                                    {else}
                                        <div class="current-price" id="current-price{$P.ID}{$BLOCK.ID}">
                                            <strong class="fw-black product-price-not-vat">{format price=$P.PRICE_SELL}</strong> {$P.TARGET_CURRENCY}
                                            <i class="ti-plus"></i> {#vat#}
                                        </div>
                                    {/if}
                                </div>
                            </div>
                            {if $P.HAS_VARIANT == true}
                                <div class="col-7 col-lg-6 offset-lg-2">
                                    <div class="row ml-0">
                                        <div class="d-flex flex-wrap w-100 variant-wrapper">
                                            {if $P.VARIANT_FEATURE1_LIST|@count > 0}
                                                <div class="col-6 pl-0">
                                                    <div class="sub-product-list">
                                                        <div class="w-100 sub-one">
                                                            {include file='block/product-detail/tpl/variants/select.tpl' SUB_LIST=$P.VARIANT_FEATURE1_LIST SELECTED=$P.VARIANT_FEATURE1_SELECTED GRUP_TIP_NO=1 VARIANT_TITLE=$P.VARIANT_FEATURE1_TITLE}
                                                        </div>
                                                    </div>
                                                </div>
                                            {/if}
                                            {if $P.VARIANT_FEATURE2_LIST|@count > 0}
                                                <div class="col-6 pl-0">
                                                    <div class="sub-product-list">
                                                        <div class="w-100 sub-two">
                                                            {include file='block/product-detail/tpl/variants/select.tpl' SUB_LIST=$P.VARIANT_FEATURE2_LIST SELECTED=$P.VARIANT_FEATURE2_SELECTED GRUP_TIP_NO=2 VARIANT_TITLE=$P.VARIANT_FEATURE2_TITLE}
                                                        </div>
                                                    </div>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                            <div class="col-5 col-lg-3 py-1 ml-auto pl-0 {if $P.HAS_VARIANT == true}pt-0{/if}">
                                <div class="d-flex align-items-center justify-content-flex-end">
                                    <div class="qty mr-5" data-toggle="qty" data-callback="qty{$BLOCK.ID}">
                                        <span class="ti-minus"></span>
                                        <input type="number" class="form-control no-arrows text-center" id="qtyCount{$P.ID}{$BLOCK.ID}" name="qtyCount{$P.ID}{$BLOCK.ID}" min="{$P.MIN_ORDER_COUNT}" step="{$P.STOCK_INCREMENT}" value="{$P.MIN_ORDER_COUNT}">
                                        <span class="ti-plus"></span>
                                    </div>
                                    <div class="add-cart-wrapper d-flex align-items-center position-relative">
                                        <input type="hidden" name="subPro{$P.ID}{$BLOCK.ID}" id="subPro{$P.ID}{$BLOCK.ID}" data-variant="{$P.HAS_VARIANT}" value="0" />
                                        <button class="btn btn-outline-primary p-0 ti-basket d-flex align-items-center justify-content-center combine-product-add" data-id="{$P.ID}" title="{#add_cart#}"></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
            <div class="col-12 py-1 border-top border-bottom">
                <div class="row justify-content-flex-end">
                    <button class="btn btn-primary combine-add-all" id="combine-add-all-{$BLOCK.ID}"><i class="ti-basket"></i> {#add_selected#}</button>
                </div>
            </div>
            <div class="col-12 py-1">
                <div class="row justify-content-between">
                    <div class="fw-bold">{#total#}</div>
                    <div class="fw-bold combine-total"><span id="combine-total-{$BLOCK.ID}">0,00</span> {$CURRENCY}</div>
                </div>
            </div>
        </div>
    </div>
</div>