{if $IS_LOADED_BY_SERVICE == 0}
    <div class="col-12 mb-2">
        <div class="row">
            <div class="col-12">
                {if $SETTING.DISPLAY_TITLE}
                    <div class="w-100 d-flex align-items-center justify-content-between mb-1">
                        <div class="block-title no-line">{$BLOCK.TITLE}</div>
                        {if $SETTING.DISPLAY_COMPARISON_BUTTON == 1 && $SETTING.TABS|@count <= 1}
                            <div class="compare-selected d-none d-md-flex">
                                <a href="javascript:void(0);" class="text-body compare-selected-btn-{$BLOCK.ID}{$BLOCK.PARENT_ID}" data-id="{$BLOCK.ID}{$BLOCK.PARENT_ID}">
                                    <i class="ti-shuffle"></i> {#compare_selected#}
                                </a>
                            </div>
                        {/if}
                    </div>
                {/if}
                {if $SETTING.TABS|@count > 1}
                    <div class="w-100 d-flex align-items-center justify-content-between mb-1">
                        <ul class="d-flex tab-nav showcase-tab-titles list-style-none showcase-tab-titles{$BLOCK.ID}{$BLOCK.PARENT_ID}">
                            {foreach from=$SETTING.TABS item=TAB name=tab}
                                <li class="{if $smarty.foreach.tab.first}loaded active {/if}{if !$smarty.foreach.tab.last}mr-2 {/if}">
                                    <a href="#producttab{$BLOCK.ID}{$BLOCK.PARENT_ID}{$smarty.foreach.tab.iteration}" data-href="{$TAB.URL}" data-toggle="tab" data-callback="tab{$BLOCK.ID}{$BLOCK.PARENT_ID}" 
                                       class="btn border text-uppercase text-center showcase-tab-item">
                                        {if $TAB.IMG|strip != ''}
                                            <span class="tab-img mr-1">
                                                <img src="{$TAB.IMG}" alt="{$BLOCK.TITLE} - {$TAB.TITLE}" width="25" height="25">
                                            </span>
                                        {/if}
                                        <span class="tab-name">{$TAB.TITLE}</span>
                                    </a>
                                </li>
                            {/foreach}
                        </ul>
                        {if $SETTING.DISPLAY_COMPARISON_BUTTON == 1}
                            <div class="compare-selected d-none d-md-flex">
                                <a href="javascript:void(0);" class="text-body compare-selected-btn-{$BLOCK.ID}{$BLOCK.PARENT_ID}">
                                    <i class="ti-shuffle"></i> {#compare_selected#}
                                </a>
                            </div>
                        {/if}
                    </div>
                {/if}
            </div>
            <div class="col-12">
                <div class="w-100 position-relative slider-block-wrapper">
                    <div class="row">
                        <div class="col-12{if $SETTING.TABS|@count > 1} tab-content tab-content{$BLOCK.ID}{$BLOCK.PARENT_ID}{/if}">
                            <div id="producttab{$BLOCK.ID}{$BLOCK.PARENT_ID}1" class="tab-pane active" data-toggle="equalHeight" data-selector=".product-detail-card">
                            {/if}
                                <div class="row">
                                    {foreach from=$PRODUCTS item=P}
                                        <div class="col-{12 / $SETTING.COL.ALL} col-sm-{12 / $SETTING.COL.SM} col-md-{12 / $SETTING.COL.MD} col-lg-{12 / $SETTING.COL.LG} col-xl-{12 / $SETTING.COL.XL} col-xxl-{12 / $SETTING.COL.XXL} mb-2 product-item">
                                            <div class="w-100 bg-white ease border product-item-inner">
                                                <div class="w-100 position-relative">                            
                                                    <a href="/{$P.URL}" class="image-wrapper {if $P.IMAGE_LIST.1.SMALL != ''}image-animate{/if}">
                                                        <picture class="image-inner">
                                                            {if $P.IMAGE.MEDIUM_WEBP_JPG != null}
                                                                <source srcset="{$P.IMAGE.SMALL}">
                                                                <img {if $IS_LAZY_LOAD_ACTIVE == '1'}src="{$LAZY_LOAD_LOADING_IMAGE}" data-src="{$P.IMAGE.MEDIUM_WEBP_JPG}" class="lazyload" loading="lazy"{else}src="{$P.IMAGE.MEDIUM_WEBP_JPG}"{/if} alt="{$P.TITLE} - {$P.BRAND}">
                                                            {else}
                                                                <img {if $IS_LAZY_LOAD_ACTIVE == '1'}src="{$LAZY_LOAD_LOADING_IMAGE}" data-src="{$P.IMAGE.SMALL}" class="lazyload" loading="lazy"{else}src="{$P.IMAGE.SMALL}"{/if} alt="{$P.TITLE} - {$P.BRAND}">
                                                            {/if}
                                                        </picture>
                                                        {if $P.IMAGE_LIST.1.SMALL != ''}
                                                            <picture class="image-inner">
                                                                <img {if $IS_LAZY_LOAD_ACTIVE == '1'}src="{$LAZY_LOAD_LOADING_IMAGE}" data-src="{$P.IMAGE_LIST.1.SMALL}" class="lazyload image-nd" loading="lazy"{else}src="{$P.IMAGE_LIST.1.SMALL}" class="image-nd"{/if} alt="{$P.TITLE} - {$P.BRAND} (1)">
                                                            </picture>
                                                        {/if}
                                                    </a>
                                                    {if $P.IS_NEW_PRODUCT == true}
                                                        <span class="new-badge">
                                                            <span class="text-uppercase fw-bold d-block">{#new#}</span>{#product#}
                                                        </span>
                                                    {/if}
                                                    {if $P.S1 == 1 || $P.S2 == 1 || $P.S3 == 1 || $P.IN_STOCK == false || ($P.STOCK > 0 && $P.STOCK < 6)}
                                                        <div class="product-symbols d-none d-md-block">
                                                            {if $P.S1 == 1}<div class="symbol-item">{$P.SYMBOL_DATA1}</div>{/if}
                                                            {if $P.S2 == 1}<div class="symbol-item">{$P.SYMBOL_DATA2}</div>{/if}
                                                            {if $P.S3 == 1}<div class="symbol-item">{$P.SYMBOL_DATA3}</div>{/if}
                                                            {if $P.STOCK > 0 && $P.STOCK < 6}
                                                                <div class="last-stock symbol-item">
                                                                    <i class="ti-attention-alt"></i> {#last#} <b>{$P.STOCK}</b> {#product#}</div>
                                                            {/if}
                                                            {if $P.IN_STOCK == false}
                                                                {if $IS_MEMBER_LOGGED_IN != true}
                                                                    {if $IS_HTTPS_ACTIVE == 1}
                                                                        <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" class="symbol-item out-of-stock popupwin">
                                                                            <i class="ti-bell-o"></i> {#stock_alert#}
                                                                        </a>
                                                                    {else}
                                                                        <a href="/{url type='page' id='5'}" class="symbol-item out-of-stock">
                                                                            <i class="ti-bell-o"></i> {#stock_alert#}
                                                                        </a>
                                                                    {/if}
                                                                {else}
                                                                    <a href="/srv/service/content-v5/sub-folder/3/1004/stock-alarm/?product={$P.ID}&variant={$P.VARIANT_ID}" class="symbol-item out-of-stock popupwin" data-type="stock">
                                                                        <i class="ti-bell-o"></i> {#stock_alert#}
                                                                    </a>
                                                                {/if}
                                                            {/if}
                                                        </div>
                                                    {/if}
                                                    {if $P.RELATED_PRODUCTS_IDS1_COUNT > 0}
                                                        <div class="product-related">
                                                            <i class="ti-circle-o"></i> + {$P.RELATED_PRODUCTS_IDS1_COUNT}
                                                        </div>
                                                    {/if}
                                                    <div class="w-100 product-buttons ease d-flex justify-content-center">
                                                        {if $SETTING.DISPLAY_CART_BUTTON == 1}
                                                            <a id="product-addcart-button-{$BLOCK.ID}{$P.ID}" class="d-block border border-circle add-to-cart-btn" href="javascript:void(0);" title="{#add_cart#}" onclick="addToCart({$P.ID}, document.getElementById('subPro{$P.ID}{$BLOCK.ID}').value, document.getElementById('ProductCount{$P.ID}{$BLOCK.ID}').value)"><i class="ti-basket"></i></a>
                                                        {/if}
                                                        {if $SETTING.IS_QUICK_VIEW_ACTIVE == 1}
                                                            <a id="product-quickview-button-{$BLOCK.ID}{$P.ID}" class="d-block border border-circle popupwin quick-view-btn" href="/srv/service/content-v5/sub-folder/3/1004/quick-view/{$P.ID}/{$P.SERVICE_CODE}" data-width="1150" title="{#quick_view#}"><i class="ti-search"></i></a>
                                                        {/if}
                                                        {if $SETTING.DISPLAY_COMPARISON_BUTTON==1}
                                                            <a id="product-compare-button-{$BLOCK.ID}{$P.ID}" class="d-none d-md-block border border-circle add-to-compare-btn" href="javascript:void(0);" data-id="{$P.ID}" onclick="return addToCompare(this);" title="{#add_compare#}"><i class="ti-shuffle"></i></a>
                                                        {/if}
                                                        {if $SETTING.DISPLAY_FAVOURITE_BUTTON == 1}
                                                            <a id="product-favourite-button-{$BLOCK.ID}{$P.ID}" class="d-block border border-circle add-favourite-btn" href="javascript:void(0);" data-id="{$P.ID}" title="{#add_favourite#}"><i class="ti-heart-o"></i></a>
                                                        {/if}
                                                    </div>
                                                </div>
                                                <div class="col-12 py-1 product-detail-card">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            {if $DISPLAY_BRAND == 1 && $P.BRAND != ''}
                                                                <a href="/{$P.BRAND_URL}" class="d-inline-block fw-bold text-body brand-title">{$P.BRAND}</a>
                                                            {/if}
                                                            <a href="/{$P.URL}" class="d-inline-block text-body product-title">{$P.TITLE}</a>
                                                        </div>
                                                        {if $P.IS_DISPLAY_PRODUCT == 0}
                                                            <div class="col-12 p-1 product-bottom-line">
                                                                <div class="row">
                                                                    <input type="hidden" name="subPro{$P.ID}{$BLOCK.ID}" id="subPro{$P.ID}{$BLOCK.ID}" value="0" />
                                                                    <input type="number" id="ProductCount{$P.ID}{$BLOCK.ID}" class="d-none" name="ProductCount{$P.ID}{$BLOCK.ID}" min="{$P.MIN_ORDER_COUNT}" step="{$P.STOCK_INCREMENT}" value="{$P.MIN_ORDER_COUNT}">
                                                                    <div class="col-12 product-price-wrapper d-flex align-items-center">
                                                                        {if $P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1}
                                                                            <span class="discounted-badge {if $P.DISCOUNT_PERCENT <= 0}d-none{/if}">
                                                                                <span class="d-block">%<span class="product-discount">{$P.DISCOUNT_PERCENT}</span></span>{#discount#}
                                                                            </span>
                                                                        {/if}
                                                                        <div class="d-block">
                                                                            {if $P.IS_DISPLAY_DISCOUNTED_ACTIVE == 1}
                                                                                <div class="product-discounted-price text-gray text-delete {if $P.DISCOUNT_PERCENT <= 0}d-none{/if}">
                                                                                    <span class="product-price-not-discounted">{vat price=$P.PRICE_NOT_DISCOUNTED vat=$P.VAT}</span> {$P.TARGET_CURRENCY}
                                                                                </div>
                                                                            {/if}
                                                                            <div class="current-price fw-bold">
                                                                                {if $P.DISPLAY_VAT === "1"}
                                                                                <strong class="product-price">{vat price=$P.PRICE_SELL vat=$P.VAT}</strong> {$P.TARGET_CURRENCY}
                                                                                {else}
                                                                                <strong class="product-price-not-vat">{format price=$P.PRICE_SELL}</strong> {$P.TARGET_CURRENCY} <i class="ti-plus"></i> {#vat#}
                                                                                {/if}
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                                {if $IS_LOADED_BY_SERVICE == 0}
                            </div>
                            {if $SETTING.TABS|@count > 1}
                                {foreach from=$SETTING.TABS item=TAB name=tab}
                                    {if !$smarty.foreach.tab.first}
                                        <div id="producttab{$BLOCK.ID}{$BLOCK.PARENT_ID}{$smarty.foreach.tab.iteration}" class="tab-pane" data-toggle="equalHeight" data-selector=".product-detail-card"></div>
                                    {/if}
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}