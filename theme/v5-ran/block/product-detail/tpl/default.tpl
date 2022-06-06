{if $P.IN_STOCK != false && $P.DEAL}
    <div class="col-12">
        {if $P.DEAL_PREV_DATE != ''}
            <div id="product-deal-timer" class="d-flex align-items-center flex-wrap bg-light border border-round product-deal-timer-passive text-danger">
                {#product_deal_timer_end1#} {$P.DEAL_PREV_DATE} {#product_deal_timer_end2#}.
            </div>
        {else}
            <div id="product-deal-timer" class="d-flex align-items-center flex-wrap bg-light border border-round"
            data-timer="{$P.DEAL_END_DATE|date_format:'Y,m,d,H,i,s'}" data-toggle="count-down">
                <div class="col-12 col-sm-auto py-1 fw-bold text-primary text-center deal-timer-title">{#product_deal_timer_title#}</div>
                <div class="col-12 col-sm-auto py-1 ml-auto d-flex align-items-center justify-content-center">
                    <div class="fw-bold mr-1 text-gray deal-timer-title">{#time_remaining#}</div>
                    <div class="deal-timer-item day">
                        <span class="d-block fw-bold timer-text">00</span>
                        <small class="small-text">{#day#}</small>
                    </div>
                    <div class="deal-timer-item hour">
                        <span class="d-block fw-bold timer-text">00</span>
                        <small class="small-text">{#hour#}</small>
                    </div>
                    <div class="deal-timer-item minute">
                        <span class="d-block fw-bold timer-text">00</span>
                        <small class="small-text">{#minute#}</small>
                    </div>
                    <div class="deal-timer-item second">
                        <span class="d-block fw-bold timer-text">00</span>
                        <small class="small-text">{#second#}</small>
                    </div>
                </div>
            </div>
        {/if}
    </div>
{/if}

<div id="product-detail" class="col-12">
    <div class="row">
        <div id="product-left" class="col-12 col-md-6 mb-2">
            <div id="product-detail-images-wrapper-{$BLOCK.ID}" class="w-100 h-100 position-relative product-detail-images-wrapper">
                <div class="w-100 position-relative border mb-2 product-detail-images">
                    <div id="product-detail-slider-{$BLOCK.ID}" class="swiper-container">
                        <div class="swiper-wrapper" id="gallery-{$BLOCK.ID}">
                            {foreach from=$P.IMAGE_LIST item=IMAGE name=image}
                            <a class="swiper-slide slide-item" data-id="{$IMAGE.VARIANT_TYPE_ID}" href="{$IMAGE.BIG}">
                                <div class="image-wrapper">
                                    <div class="image-inner">
                                        <figure class="image-zoom">
                                            <img src="{$IMAGE.MEDIUM}" alt="{$P.TITLE} - {$smarty.foreach.image.iteration}" data-toggle="zoom-image" data-target="#product-right" data-width="450" data-height="450" data-image="{$IMAGE.BIG}">
                                        </figure>
                                    </div>
                                </div>
                            </a>
                            {/foreach}
                        </div>
                    </div>
                    <div id="swiper-prev-{$BLOCK.ID}" class="swiper-button-prev inside"><i class="ti-arrow-left"></i></div>
                    <div id="swiper-next-{$BLOCK.ID}" class="swiper-button-next inside"><i class="ti-arrow-right"></i></div>
                    {if $P.IS_NEW_PRODUCT == true}
                        <span class="new-badge">
                            <span class="text-uppercase fw-bold d-block">{#new#}</span>{#product#}
                        </span>
                    {/if}
                </div>
                {if $P.IMAGE_COUNT > 1}
                    <div class="w-100 position-relative product-thumb-slider-wrapper">
                        <div id="product-thumb-slider-{$BLOCK.ID}" class="swiper-container">
                            <div class="swiper-wrapper">
                                {foreach from=$P.IMAGE_LIST item=IMAGE name=image}
                                    <div class="swiper-slide border slide-item" data-id="{$IMAGE.VARIANT_TYPE_ID}">
                                        <div class="image-wrapper">
                                            <figure class="image-inner">
                                                <img src="{$IMAGE.SMALL}" alt="{$P.TITLE} - {$smarty.foreach.image.iteration}">
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
        </div>
        <div id="product-right" class="col-12 col-md-6 mb-2 py-1">
            {if $P.BRAND != '' || $P.SUPPLIER_PRODUCT_CODE != ''}
                <div class="row align-items-center">
                    {if $P.BRAND != ''}
                        <div id="brand-title" class="col-auto">
                            <a href="{$P.BRAND_URL}" title="{$P.BRAND}" class="fw-bold text-black">{$P.BRAND}</a>
                        </div>
                    {/if}
                    {if $P.SUPPLIER_PRODUCT_CODE != ''}
                        <div id="product-code" class="col-auto ml-auto text-gray">
                            {#product_code#} : <span id="supplier-product-code">{$P.SUPPLIER_PRODUCT_CODE}</span>
                        </div>
                    {/if}
                </div>
            {/if}
            <h1 id="product-title" class="text-black mb-1 w-lg-75">{$P.TITLE}</h1>
            {if $P.SHOW_VENDOR == 1 && $P.IS_DISPLAY_PRODUCT == 1}
                <div class="w-100 mb-1">
                    {#vendor_check_1#} <a href="/{url type='page' id='21'}" class="fw-bold text-primary text-underline">{#vendor_check_2#}</a> {#vendor_check_3#}.
                </div>
            {/if}
            {if $P.IS_DISPLAY_PRODUCT == 0}
                <div class="row">
                    <div class="col-12 col-md mb-1">
                        <div class="price-wrapper d-flex flex-wrap align-items-center">
                            {if $P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1}
                                <span class="discounted-badge mr-1 {if $P.DISCOUNT_PERCENT <= 0}d-none{/if}">
                                    <span class="d-block">%<span class="product-discount">{$P.DISCOUNT_PERCENT}</span></span>{#discount#}
                                </span>
                            {/if}
                            <div class="product-price-wrapper">
                                {if $P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1}
                                    <div class="product-discounted-price text-gray text-delete {if $P.IS_DISCOUNT_ACTIVE != 1}d-none{/if}" data-old="{$P.PRICE_BUY}">
                                        {if $P.DISPLAY_VAT == 1}
                                            <span class="product-price-not-discounted">{vat price=$P.PRICE_NOT_DISCOUNTED vat=$P.VAT}</span> {$P.TARGET_CURRENCY}
                                        {else}
                                            <span class="product-price-not-discounted-not-vat">{format price=$P.PRICE_NOT_DISCOUNTED}</span> {$P.TARGET_CURRENCY} + {#vat#}
                                        {/if}
                                    </div>
                                {/if}
                                <div class="product-current-price text-primary fw-bold" data-old="{$P.BUY}">
                                    {if $P.DISPLAY_VAT == 1}
                                        <span class="product-price">{vat price=$P.PRICE_SELL vat=$P.VAT}</span> {$P.TARGET_CURRENCY}
                                    {else}
                                        <span class="product-price-not-vat">{format price=$P.PRICE_SELL}</span> {$P.TARGET_CURRENCY} + {#vat#}
                                    {/if}
                                </div>
                            </div>
                            {if $P.IS_MONEY_ORDER_ACTIVE == true}
                                <div class="w-100 product-money-price mt-1">
                                    <div class="d-flex align-items-center">
                                        {#money_price#} :
                                        <div class="fw-bold ml-1">
                                            {if $P.DISPLAY_VAT == 1}
                                                <span class="money-order-price">{vat price=$P.PRICE_MONEY_ORDER vat=$P.VAT}</span> {$P.TARGET_CURRENCY}
                                            {else}
                                                <span class="money-order-price-not-vat">{format price=$P.PRICE_MONEY_ORDER}</span> {$P.TARGET_CURRENCY} + {#vat#}
                                            {/if}
                                        </div>
                                    </div>
                                    {if $P.MONEY_ORDER_PERCENT != 0}
                                        <span class="product-money-discount-percent text-primary">
                                            <span class="fw-bold money-discount">
                                                %{if $P.MONEY_ORDER_PERCENT < 0}{$P.MONEY_ORDER_PERCENT * -1}{else}{$P.MONEY_ORDER_PERCENT}{/if}
                                            </span>&nbsp;{#discount#}
                                        </span>
                                    {/if}
                                </div>
                            {/if}
                        </div>
                    </div>
                    <div class="col-12 col-lg-6 ml-auto mb-1">
                        <div class="product-symbol-badge d-flex align-items-center justify-content-flex-end flex-wrap">
                            {if $P.S1 == 1}
                                <div class="symbol-badge" data-toggle="tooltip" data-title="{$SYMBOL_TAG1}">{$SYMBOL_DATA1}</div>
                            {/if}
                            {if $P.STOCK > 0 && $P.STOCK < 6}
                                <div class="last-stock symbol-badge">
                                    <i class="ti-attention-alt"></i> {#last#} <b>{$P.STOCK}</b> {#product#}
                                </div>
                            {/if}
                            {if $P.S2 == 1}
                                <div class="symbol-badge" data-toggle="tooltip" data-title="{$SYMBOL_TAG2}">{$SYMBOL_DATA2}</div>
                            {/if}
                            {if $P.S3 == 1}
                                <div class="symbol-badge" data-toggle="tooltip" data-title="{$SYMBOL_TAG3}">{$SYMBOL_DATA3}</div>
                            {/if}
                        </div>
                    </div>
                </div>
            {/if}
            <div class="w-100 border-top border-bottom mb-2">
                <div class="row align-items-center">
                    {if $P.BRAND != ''}
                        <div class="col-auto py-1 text-gray">
                            {#more#} <a href="{$P.BRAND_URL}" id="more-brand" class="text-primary">{$P.BRAND}</a> {#product_#}
                        </div>
                    {/if}
                    <div class="col-auto py-1 text-gray">
                        {#more#} <a href="{$P.CATEGORY_URL}" id="more-category" class="text-primary">{$P.CATEGORY_NAME}</a> {#product_#}
                    </div>
                    {if $IS_COMMENT_RATE_ACTIVE == 1 && $P.RANK_TOTAL > 0}
                        <div class="col-auto py-1 ml-lg-auto text-right d-flex d-md-block">
                            <div class="d-flex align-items-center">
                                <div class="text-gray">{#comments#} ({$P.COMMENT_COUNT})</div>
                                <span class="comment-line text-gray">|</span>
                                <a href="javascript:void(0);" id="comment-do-scroll" onclick="scrollToElm('[href=\'#product-comments\']');" class="text-gray">{#comment_do#}</a>
                            </div>
                            <div class="stars product-stars text-left ml-1 ml-md-0">
                                {for $star=1 to 5}<i class="ti-star"></i>{/for}
                                <span class="stars-fill" style="width:{$P.COMMENT_RANK * 100 / 5}%">
                                    {for $star=1 to 5}<i class="ti-star"></i>{/for}
                                </span>
                                {if $P.RANK_TOTAL > 0}
                                <div class="d-none star-average-hover pt-1 text-gray">
                                    <div class="p-1 bg-white border border-round star-average-box position-relative">
                                        <div class="row">
                                            <div class="col-12 mb-1 total-average">
                                                <strong class="text-primary">{$P.COMMENT_RANK|string_format:"%.1f"}</strong> {#average_point#}
                                            </div>
                                            <div class="col-12">
                                                <ul class="list-style-none star-average">
                                                    {for $i=1 to 5}
                                                        <li class="d-flex align-items-center">
                                                            <strong>{6 - $i}</strong>
                                                            <div class="stars">
                                                                {for $star=1 to 5}<i class="ti-star"></i>{/for}
                                                                <span class="stars-fill" style="width:{(6 - $i) * 20}%">
                                                                    {for $star=1 to 5}<i class="ti-star"></i>{/for}
                                                                </span>
                                                            </div>
                                                            <div class="position-relative bg-light border-round progress-bar">
                                                                <span class="bg-primary border-round position-absolute h-100 progress-bar-fill" style="width:{$P['RANK'|cat:(6 - $i):'_COUNT'] * 100 / $P.RANK_TOTAL}%"></span>
                                                            </div>
                                                            <span class="comment-count">{$P['RANK'|cat:(6 - $i):'_COUNT']}</span>
                                                        </li>
                                                    {/for}
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {/if}
                            </div>
                        </div>
                    {/if}
                </div>
            </div>
            {if $P.SHORT_DESCRIPTION != ''}
                <div class="mb-2 short-description">
                    <div class="short-description-title">{#short_description#}</div>
                    <div class="short-description-content text-gray">{$P.SHORT_DESCRIPTION}</div>
                </div>
            {/if}
            {if $P.IS_DISPLAY_PRODUCT == 0}
                <input type="hidden" name="subPro{$P.ID}{$BLOCK.ID}" id="subPro{$P.ID}{$BLOCK.ID}" value="{$P.VARIANT_ID}" />
                {if $P.HAS_VARIANT == 1}
                    <div class="w-100 position-relative popover-wrapper">
                        <div class="variant-overlay" data-id="{$P.ID}"></div>
                        <div class="w-100 variant-wrapper">
                            <div class="row">
                                {if $P.VARIANT_FEATURE1_LIST|@count > 0}
                                    <div class="col-12 sub-product-list mb-1">
                                        <div class="text-black feature-title mb-1">{$P.VARIANT_FEATURE1_TITLE|default:{#choose#}}</div>
                                        <div class="sub-one">
                                            {include file='block/product-detail/tpl/variants/real-image.tpl' SUB_LIST=$P.VARIANT_FEATURE1_LIST SELECTED=$P.VARIANT_FEATURE1_SELECTED GRUP_TIP_NO=1 VARIANT_TITLE=$P.VARIANT_FEATURE1_TITLE}
                                        </div>
                                    </div>
                                {/if}
                                {if $P.VARIANT_FEATURE2_LIST|@count > 0}
                                    <div class="col-12 sub-product-list mb-1">
                                        <div class="text-black feature-title mb-1">{$P.VARIANT_FEATURE2_TITLE|default:{#choose#}}</div>
                                        <div class="sub-two">
                                            {include file='block/product-detail/tpl/variants/button.tpl' SUB_LIST=$P.VARIANT_FEATURE2_LIST SELECTED=$P.VARIANT_FEATURE2_SELECTED GRUP_TIP_NO=2 VARIANT_TITLE=$P.VARIANT_FEATURE2_TITLE}
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/if}
                {if $P.IS_PERSONALIZATION_ACTIVE}
                    <div id="product-personalization-wrapper" class="w-100 mt-1" data-id="{$P.ID}" data-sub="{$P.VARIANT_ID}" data-form="{$P.PERSONALIZATION_ID}">
                        {subfolder pageId="3" blockId="1004" subfolder="personalization"}
                    </div>
                {/if}
                <div class="w-100 in-stock-available {if $P.STOCK<1 && $NEGATIVE_STOCK == 0 && $P.HAS_VARIANT == false}d-none{else}{/if}">
                    <div class="row align-items-center product-add-buttons mb-2">
                        <div class="col-auto flex-shrink-0">
                            <div class="w-100 product-qty qty{$P.ID}{$BLOCK.ID}" data-toggle="qty" {if $P.IS_MULTIPLE_DISCOUNT_ACTIVE == 1} data-multiple="true"{/if}>
                                <span class="ti-minus"></span>
                                <span class="ti-plus"></span>
                                <input type="number" class="form-control no-arrows text-center" id="ProductCount{$P.ID}{$BLOCK.ID}" name="ProductCount{$P.ID}{$BLOCK.ID}" min="{$P.MIN_ORDER_COUNT}" step="{$P.STOCK_INCREMENT}" value="{$P.MIN_ORDER_COUNT}">
                            </div>
                        </div>
                        <div class="col">
                            <button id="addToCartBtn" class="w-100 btn btn-primary text-uppercase" onclick="addToCart({$P.ID}, document.getElementById('subPro{$P.ID}{$BLOCK.ID}').value, document.getElementById('ProductCount{$P.ID}{$BLOCK.ID}').value)">
                                {#add_cart#}
                            </button>
                        </div>
                        <div class="col d-none d-md-block">
                            <button id="fastAddToCartBtn" class="w-100 btn btn-black text-uppercase" onclick="addToCart({$P.ID}, document.getElementById('subPro{$P.ID}{$BLOCK.ID}').value, document.getElementById('ProductCount{$P.ID}{$BLOCK.ID}').value, 1)">{#buy_now#}</button>
                        </div>
                        <div class="col-auto flex-shrink-0">
                            {if $IS_MEMBER_LOGGED_IN != true}
                                {if $IS_HTTPS_ACTIVE == 1}
                                    <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" id="addToFavBtn" data-toggle="tooltip" data-title="{#like#}" class="w-100 border border-circle popupwin">
                                        <i class="ti-heart-o ease"></i>
                                    </a>
                                {else}
                                    <a href="/{url type='page' id='5'}" id="addToFavBtn" data-toggle="tooltip" data-title="{#like#}" class="w-100 border border-circle">
                                        <i class="ti-heart-o ease"></i>
                                    </a>
                                {/if}
                            {else}
                                <a href="javascript:void(0);" data-id="{$P.ID}" id="addToFavBtn" data-toggle="tooltip" data-title="{#like#}" class="w-100 border border-circle add-favourite-btn">
                                    <i class="ti-heart-o ease"></i>
                                </a>
                            {/if}
                        </div>
                    </div>
                    {if $P.SUBSCRIBE == 1}
                        <div class="product-subscribe border d-flex mb-2">
                            <input type="checkbox" id="product-subscribe-{$P.ID}" class="form-control" data-discount="{$P.SUBSCRIBE_DISCOUNT_RATE}" data-toggle="subscribe">
                            <label for="product-subscribe-{$P.ID}" class="col-12 col-sm-6 border-right py-1 d-flex align-items-center m-0 fw-regular">
                                <span class="input-checkbox"><i class="ti-check"></i></span>
                                {#subscribe#}
                            </label>
                            <select id="product-subscribe-frequency-{$P.ID}" class="col-12 col-sm-6 form-control py-1 border-0" name="subscribe_frequency">
                                {foreach $P.SUBSCRIBE_FREQUENCY_LIST as $FREQUENCY}
                                    {assign var="subs_name" value="subs_"|cat:$FREQUENCY}
                                    <option value="{$FREQUENCY}">{#$subs_name#}</option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}
                </div>
                <div class="w-100 out-stock-available mb-2 {if $P.STOCK<1 && $NEGATIVE_STOCK == 0 && $P.HAS_VARIANT == false}{else}d-none{/if}">
                    <div class="w-100 border">
                        <div class="col-12 p-1 text-center bg-light fw-bold out-of-stock">
                            {#out_of_stock#}
                        </div>
                        {if $IS_MEMBER_LOGGED_IN != true}
                            {if $IS_HTTPS_ACTIVE == 1}
                                <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" class="d-flex align-items-center justify-content-center p-1 text-body out-stock-btn popupwin"><i class="ti-bell-o mr-1"></i> {#stock_alert#}</a>
                            {else}
                                <a href="/{url type='page' id='5'}" class="d-flex align-items-center justify-content-center out-stock-btn p-1 text-body"><i class="ti-bell-o mr-1"></i> {#stock_alert#}</a>
                            {/if}
                        {else}
                            <a href="/srv/service/content-v5/sub-folder/{$PAGE_ID}/{$BLOCK.PARENT_ID}/stock-alarm/?product={$P.ID}&variant={$P.VARIANT_ID}" class="d-flex align-items-center justify-content-center p-1 text-body out-stock-btn popupwin" data-type="stock"><i class="ti-bell-o mr-1"></i> {#stock_alert#}</a>
                        {/if}
                    </div>
                </div>
            {/if}
            {if $P.S1 == 1 || $P.S2 == 1 || $P.S3 == 1 || $P.S4 == 1 || $P.S5 == 1 || $P.S6 == 1 || $P.S7 == 1 || $P.S8 == 1 || $P.S9 == 1 || $P.S10 == 1}
                <div class="w-100 product-symbols">
                    <div class="row">
                        {if $P.S4 == 1}
                            <div class="col-4 col-sm-3 mb-1">
                                <div class="border border-round d-flex align-items-center justify-content-center p-1 h-100" data-toggle="tooltip" data-title="{$SYMBOL_TAG4}">{$SYMBOL_DATA4}</div>
                            </div>
                        {/if}
                        {if $P.S5 == 1}
                            <div class="col-4 col-sm-3 mb-1">
                                <div class="border border-round d-flex align-items-center justify-content-center p-1 h-100" data-toggle="tooltip" data-title="{$SYMBOL_TAG5}">{$SYMBOL_DATA5}</div>
                            </div>
                        {/if}
                        {if $P.S6 == 1}
                            <div class="col-4 col-sm-3 mb-1">
                                <div class="border border-round d-flex align-items-center justify-content-center p-1 h-100" data-toggle="tooltip" data-title="{$SYMBOL_TAG6}">{$SYMBOL_DATA6}</div>
                            </div>
                        {/if}
                        {if $P.S7 == 1}
                            <div class="col-4 col-sm-3 mb-1">
                                <div class="border border-round d-flex align-items-center justify-content-center p-1 h-100" data-toggle="tooltip" data-title="{$SYMBOL_TAG7}">{$SYMBOL_DATA7}</div>
                            </div>
                        {/if}
                        {if $P.S8 == 1}
                            <div class="col-4 col-sm-3 mb-1">
                                <div class="border border-round d-flex align-items-center justify-content-center p-1 h-100" data-toggle="tooltip" data-title="{$SYMBOL_TAG8}">{$SYMBOL_DATA8}</div>
                            </div>
                        {/if}
                        {if $P.S9 == 1}
                            <div class="col-4 col-sm-3 mb-1">
                                <div class="border border-round d-flex align-items-center justify-content-center p-1 h-100" data-toggle="tooltip" data-title="{$SYMBOL_TAG9}">{$SYMBOL_DATA9}</div>
                            </div>
                        {/if}
                        {if $P.S10 == 1}
                            <div class="col-4 col-sm-3 mb-1">
                                <div class="border border-round d-flex align-items-center justify-content-center p-1 h-100" data-toggle="tooltip" data-title="{$SYMBOL_TAG10}">{$SYMBOL_DATA10}</div>
                            </div>
                        {/if}
                    </div>
                </div>
            {/if}
            {if $P.IS_DISPLAY_PRODUCT == 0}
                {if $P.IS_MULTIPLE_DISCOUNT_ACTIVE == 1}
                    <div id="product-multiple-discount" class="mb-1">
                        <div class="product-multiple-title d-flex align-items-center justify-content-between mb-1">
                            <div class="block-title">{#multiple_discount#}</div>
                        </div>
                        <div class="col-12 product-multiple-list border border-light border-round">
                            <div class="row">
                                <div class="product-multiple-left flex-shrink-0 border-right border-light d-flex flex-wrap">
                                    <div class="col-12 p-10 text-center text-primary fw-semibold h-sm-50 border-bottom border-light">{#amount#}</div>
                                    <div class="col-12 p-10 text-center text-primary fw-semibold h-sm-50">{#discount#}</div>
                                </div>
                                <div class="col p-0 d-flex product-multiple-scroll">
                                    {foreach from=$P.MULTIPLE_DISCOUNT item=M_D}
                                        <div class="col-12 p-0 text-center product-multiple-item border-right border-light" data-min="{$M_D.MIN}" data-max="{$M_D.MAX}" data-percent="{$M_D.PERCENT}">
                                            <div class="col-12 p-10 d-flex align-items-center border-bottom border-light justify-content-center h-sm-50"><span>{$M_D.MIN}</span> - <span>{$M_D.MAX}</span></div>
                                            <div class="col-12 p-10 d-flex align-items-center justify-content-center h-sm-50">%{$M_D.PERCENT}</div>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
            {/if}
            <div id="product-buttons" class="w-100 border-top border-bottom py-1">
                <div class="row">
                    {if $IS_RECOMMENDATION_ACTIVE == 1}
                        <div class="col-auto py-1">
                            <a href="javascript:void(0);" class="text-black" id="advice-btn" onclick="scrollToElm('[href=\'#product-recommend\']', 200);">
                                <i class="ti-mail-o"></i> {#recommend#}
                            </a>
                        </div>
                    {/if}
                    <div class="col-auto py-1">
                        {if $IS_MEMBER_LOGGED_IN != true}
                            {if $IS_HTTPS_ACTIVE == 1}
                                <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" class="text-black popupwin" id="price-alert-link">
                                    <i class="ti-bell-o"></i> {#price_alert#}
                                </a>
                            {else}
                                <a href="/{url type='page' id='5'}" class="text-black" id="price-alert-link">
                                    <i class="ti-bell-o"></i> {#price_alert#}
                                </a>
                            {/if}
                        {else}
                            <a href="/srv/service/content-v5/sub-folder/{$PAGE_ID}/{$BLOCK.PARENT_ID}/price-alarm/?product={$P.ID}&variant={$P.VARIANT_ID}" class="text-black popupwin" id="price-alert-link" data-type="price">
                                <i class="ti-bell-o"></i> {#price_alert#}
                            </a>
                        {/if}
                    </div>
                    {if $P.IS_ORDER_NOTE_ACTIVE==1}
                        <div class="col-auto py-1">
                            <div class="dropdown product-note-dropdown">
                                <a href="#" class="text-black" data-toggle="dropdown">
                                    <i class="ti-comment-o"></i> {#note#}
                                </a>
                                <div class="dropdown-menu mb-1 border-round p-1">
                                    <textarea id="order-note-{$P.ID}" class="form-control" placeholder="{#note#}:"></textarea>
                                </div>
                            </div>
                        </div>
                    {/if}
                    {if $P.DELIVERY_DAY|strip != ''}
                        <div class="col-12 col-md-auto py-1 ml-auto">
                            <div class="delivery-time text-black">
                                <i class="ti-truck-o"></i> <span class="text-primary">{$P.DELIVERY_TIME}</span>&nbsp;tarihine kadar kargoda
                            </div>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
        <div class="col-12 product-detail-tab-container mb-3">
            <div class="w-100">
                <ul id="product-detail-tab" class="tab-nav list-style-none d-flex">
                    <li class="active mr-1">
                        <a class="d-flex align-items-center" id="tab-product-features" href="#product-features" data-toggle="tab">{#features#}</a>
                    </li>
                    {if $P.IS_DISPLAY_PRODUCT != true}
                        <li class="mr-1">
                            <a class="d-flex align-items-center" id="tab-product-payment" href="#product-payment" data-toggle="tab" data-href="/srv/service/content-v5/sub-folder/{$BLOCK.PAGE_ID}/{$BLOCK.PARENT_ID}/installment-list?product={$P.ID}">{#payment#}</a>
                        </li>
                    {/if}
                    <li class="mr-1">
                        <a class="d-flex align-items-center" id="tab-product-comments" href="#product-comments" data-toggle="tab" data-href="/srv/service/content-v5/sub-folder/{$BLOCK.PAGE_ID}/{$BLOCK.PARENT_ID}/comments?product={$P.ID}">{#comments#}{if $P.COMMENT_COUNT > 0} ({$P.COMMENT_COUNT}){/if}</a>
                    </li>
                    {if $IS_RECOMMENDATION_ACTIVE == 1}
                        <li class="mr-1">
                            <a class="d-flex align-items-center" id="tab-product-recommend" href="#product-recommend" data-toggle="tab" data-href="/srv/service/content-v5/sub-folder/{$BLOCK.PAGE_ID}/{$BLOCK.PARENT_ID}/recommend?product={$P.ID}">{#recommend#}</a>
                        </li>
                    {/if}
                    <li class="mr-1">
                        <a class="d-flex align-items-center" id="tab-product-images" href="#product-images" data-toggle="tab" data-href="/srv/service/content-v5/sub-folder/{$BLOCK.PAGE_ID}/{$BLOCK.PARENT_ID}/images?product={$P.ID}">{#images#}</a>
                    </li>
                    {if $P.DOCUMENT_INFO != ''}
                        <li class="mr-1">
                            <a class="d-flex align-items-center" id="tab-product-document" href="#product-document" data-toggle="tab">{#document#}</a>
                        </li>
                    {/if}
                    {if $P.IS_VIDEO_ACTIVE == 1}
                        <li class="mr-1">
                            <a class="d-flex align-items-center" id="tab-product-video" href="#product-video" data-toggle="tab">{#video#}</a>
                        </li>
                    {/if}
                    {if $IS_CALL_ME_ACTIVE == 1}
                        <li class="mr-1">
                            <a class="d-flex align-items-center" id="tab-product-callme" href="#product-callme" data-toggle="tab" data-href="/srv/service/content-v5/sub-folder/{$BLOCK.PAGE_ID}/{$BLOCK.PARENT_ID}/call-me?product={$P.ID}">{#callme#}</a>
                        </li>
                    {/if}
                    {if $IS_QUICK_MESSAGE_ACTIVE == 1}
                        <li class="mr-1">
                            <a class="d-flex align-items-center" id="tab-product-quick-message" href="#product-quick-message" data-toggle="tab" data-href="/srv/service/content-v5/sub-folder/{$BLOCK.PAGE_ID}/{$BLOCK.PARENT_ID}/quick-message?product={$P.ID}">{#quick_message#}</a>
                        </li>
                    {/if}
                    {if $IS_SUGGESTION_BOX_ACTIVE == 1}
                        <li class="mr-1">
                            <a class="d-flex align-items-center" id="tab-product-suggestion-box" href="#product-suggestion-box" data-toggle="tab" data-href="/srv/service/content-v5/sub-folder/{$BLOCK.PAGE_ID}/{$BLOCK.PARENT_ID}/suggestion-box?product={$P.ID}">{#suggestion_box#}</a>
                        </li>
                    {/if}
                </ul>
            </div>
            <div class="w-100 mt-1 border p-3 tab-content">
                <div id="product-features" class="w-100 tab-pane active">
                    <div class="row">
                        <div id="product-fullbody" class="col-12 col-lg-8 text-gray">
                            {$P.DETAIL}
                        </div>
                        {if $P.IS_PRODUCT_SIZE_ACTIVE == true || $P.WEIGHT != '' || $P.WARRANTY_INFO != '' || $P.DELIVERY_INFO != '' || $FILTER_PROPERTY_LIST|@count > 0}
                            <div class="col-12 col-md-4 mb-1">
                                <div class="col-12 border border-bottom-0">
                                    {if $P.IS_PRODUCT_SIZE_ACTIVE == true}
                                        <div class="row align-items-center border-bottom">
                                            <div class="col-4 py-1 text-black">{#dimension#}</div>
                                            <div class="col-8 py-1 text-gray">{$P.WIDTH} x {$P.HEIGHT} x {$P.DEPTH}</div>
                                        </div>
                                    {/if}
                                    {if $P.WEIGHT != ''}
                                        <div class="row align-items-center border-bottom">
                                            <div class="col-4 py-1 text-black">{#weight#}</div>
                                            <div class="col-8 py-1 text-gray">{$P.WEIGHT}</div>
                                        </div>
                                    {/if}
                                    {if $P.WARRANTY_INFO != ''}
                                        <div class="row align-items-center border-bottom">
                                            <div class="col-4 py-1 text-black">{#warranty#}</div>
                                            <div class="col-8 py-1 text-gray">{$P.WARRANTY_INFO}</div>
                                        </div>
                                    {/if}
                                    {if $P.DELIVERY_INFO != ''}
                                        <div class="row align-items-center border-bottom">
                                            <div class="col-4 py-1 text-black">{#delivery#}</div>
                                            <div class="col-8 py-1 text-gray">{$P.DELIVERY_INFO}</div>
                                        </div>
                                    {/if}
                                    {if $FILTER_PROPERTY_LIST|@count > 0}
                                        {foreach $FILTER_PROPERTY_LIST as $F}
                                            {if $F.VALUE != ''}
                                                <div class="row align-items-center border-bottom">
                                                    <div class="col-4 py-1 text-black">{$F.KEY}</div>
                                                    <div class="col-8 py-1 text-gray" style="word-break: break-word;">{$F.VALUE}</div>
                                                </div>
                                            {/if}
                                        {/foreach}
                                    {/if}
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>
                {if $P.IS_DISPLAY_PRODUCT != true}
                    <div id="product-payment" class="w-100 tab-pane"></div>
                {/if}
                <div id="product-comments" class="w-100 tab-pane"></div>
                {if $IS_RECOMMENDATION_ACTIVE == 1}
                    <div id="product-recommend" class="w-100 tab-pane"></div>
                {/if}
                <div id="product-images" class="w-100 tab-pane"></div>
                {if $P.DOCUMENT_INFO != ''}
                    <div id="product-document" class="w-100 tab-pane">
                        {$P.DOCUMENT_INFO}
                    </div>
                {/if}
                {if $P.IS_VIDEO_ACTIVE == 1}
                    <div id="product-video" class="w-100 tab-pane">
                        {if $P.VIDEO_INFO.Baslik}
                            <div class="block-title mb-1">{$P.VIDEO_INFO.Baslik}</div>
                        {/if}
                        {if $P.VIDEO_INFO.Embed}
                            <div class="w-100 video-popup">{$P.VIDEO_INFO.Embed}</div>
                        {/if}
                    </div>
                {/if}
                {if $IS_CALL_ME_ACTIVE == 1}
                    <div id="product-callme" class="w-100 tab-pane"></div>
                {/if}
                {if $IS_QUICK_MESSAGE_ACTIVE == 1}
                    <div id="product-quick-message" class="w-100 tab-pane"></div>
                {/if}
                {if $IS_SUGGESTION_BOX_ACTIVE == 1}
                    <div id="product-suggestion-box" class="w-100 tab-pane"></div>
                {/if}
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="product-id" value="{$P.ID}" />
<input type="hidden" id="product-name" value="{$P.TITLE}" />
<input type="hidden" id="product-category-name" value="{$P.CATEGORY_NAME}" />
<input type="hidden" id="product-currency" value="{$P.CURRENCY}" />
<input type="hidden" id="product-price" value="{$P.PRICE_SELL}" />
<input type="hidden" id="product-price-vat-include" value="{vat price=$P.PRICE_SELL  vat=$P.VAT}" />
<input type="hidden" id="product-supplier-code" value="{$P.SUPPLIER_PRODUCT_CODE}" />
<input type="hidden" id="product-stock-status" value="{if $P.STOCK>0}1{else}0{/if}" />  
<input type="hidden" id="product-category-ids" value="{$P.CATEGORY_IDS}" /> 
