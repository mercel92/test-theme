<div class="col-12">
    <div class="row">
        {if $IS_HOME_PAGE == 0}
            <div class="col-12 mb-1">
                <div id="product-list-panel" class="w-100">
                    <div class="row align-items-center">
                        {if $SETTING.IS_FILTER_PANEL_ACTIVE == 1}
                            <div class="col-6 d-md-none">
                                <a id="filter-drawer" href="#product-filter" data-toggle="drawer" data-platform="mobile" class="w-100 d-flex align-items-center btn text-body border-secondary">
                                    {#filter#} <i class="ti-filter ml-auto"></i>
                                </a>
                            </div>
                        {/if}
                        {if $SETTING.SORT|@count >= 1}
                            <div class="col-6 col-sm-auto">
                                {$SORT_NAMES = [
                                    "{#order_by_default#}",
                                    "{#order_by_alphabetical_asc#}",
                                    "{#order_by_alphabetical_desc#}",
                                    "{#order_by_newest#}",
                                    "{#order_by_oldest#}",
                                    "{#order_by_price_asc#}",
                                    "{#order_by_price_desc#}",
                                    "{#order_by_random#}",
                                    "{#order_by_score#}"
                                ]}
                                <select name="sort" id="sort" class="form-control" onchange="window.location.href = T.getLink('sort', this.options[this.selectedIndex].value)">
                                    {foreach from=$SETTING.SORT item=S}
                                        <option value="{$S}" {if $smarty.get.sort}{if $smarty.get.sort == $S}selected{/if}{else if $S==0}selected{/if}>{$SORT_NAMES[$S]}</option>
                                    {/foreach}
                                </select>
                            </div>
                        {/if}
                        <div class="col-auto d-none d-md-block">
                            <div class="position-relative">
                                <input type="checkbox" id="product-list-stock" class="form-control" {if $smarty.get.stock == 1}checked value="" {else}value="1"{/if} onchange="window.location.href = T.getLink('stock', this.value)">
                                <label for="product-list-stock" id="label-product-list-stock" class="m-0 d-flex align-items-center fw-regular">
                                    <span class="input-checkbox"><i class="ti-check"></i></span>Sadece Stoktakiler
                                </label>
                            </div>
                        </div>
                        {if $SETTING.DISPLAY_COMPARISON_BUTTON==1}
                            <div class="col-auto d-none d-md-block">
                                <a href="javascript:void(0);" onclick="return compareSelectedProducts({$BLOCK.PAGE_ID}, {$BLOCK.PARENT_ID});" id="product-comparison" class="text-body"><i class="ti-shuffle"></i> {#compare_selected#}</a>
                            </div>
                            {if $SETTING.DISPLAY_CART_BUTTON == 1}
                                <div class="col-auto d-none d-md-block">
                                    {if $IS_SELECTABLE_PRODUCT == 1}
                                        <a href="javascript:void(0);" onclick="addToSelectionProducts()" id="product-add-all" class="text-primary"><i class="ti-basket"></i> {#add_to_selection#}</a>
                                    {else}
                                        <a href="javascript:void(0);" onclick="window.location.href = T.getLink('sp', {($IS_SELECTABLE_PRODUCT == 0) ? 1 : 0});" id="product-add-all" class="text-body"><i class="ti-basket"></i> {#select_and_add#}</a>
                                    {/if}
                                </div>
                            {/if}
                            {if $IS_SELECTABLE_PRODUCT == 1}
                                <div class="pr-1 d-none d-md-block">
                                    <a href="javascript:void(0);" id="product-select-destroy-btn" onclick="destroySelectionProducts()" class="text-gray">{#clear#} <i class="ti-trash-o"></i></a>
                                </div>
                                <div class="d-none d-md-block">
                                    <a href="javascript:void(0);" id="product-select-cancel-btn" onclick="window.location.href = T.getLink('sp', '');" class="text-body">İptal</a>
                                </div>
                            {/if}
                        {/if}
                    </div>
                </div>
            </div>
        {/if}
        <input type="hidden" id="search-word" value="{$SEARCH_WORD}"/>
        <input type="hidden" id="category-name" value="{$CATEGORY_NAME}"/>
        <div class="col-12" data-toggle="equalHeight" data-selector=".product-detail-card">
            <div id="catalog{$BLOCK.ID}" class="row">
                {foreach from=$PRODUCTS item=P}
                <div class="col-{12 / $SETTING.PERVIEW.ALL} col-sm-{12 / $SETTING.PERVIEW.SM} col-md-{12 / $SETTING.PERVIEW.MD} col-lg-{12 / $SETTING.PERVIEW.LG} col-xl-{12 / $SETTING.PERVIEW.XL} col-xxl-{12 / $SETTING.PERVIEW.XXL} mb-2 product-item">
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
        </div>
        {if $IS_HOME_PAGE == 0}
            <div class="col-12 mb-2">
                <div class="row align-items-center">
                    <div class="col-12 col-md-auto pagination-info-bar text-center py-1">
                        {capture assign=pagination_total}<span class="text-primary fw-bold">{$TOTAL}</span>{/capture}
                        {if $SEARCH_WORD != '' && $TOTAL == 0}
                            {#no_search_result#}
                        {else if $SEARCH_WORD != '' && $TOTAL > 0}
                            {{#total_search_result#}|replace:'%TOTAL%':$pagination_total}
                        {else if $TOTAL==0}
                            {#no_product#}
                        {else}
                            {{#total_search_result#}|replace:'%TOTAL%':$pagination_total}
                        {/if}
                    </div>
                    {if $IS_AUTO_LOAD_ACTIVE == true}
                        <input type="hidden" id="is-auto-load-active-{$BLOCK.ID}{$BLOCK.PARENT_ID}" value="1">
                    {else}
                        <div class="col-12 col-md-auto ml-auto d-flex justify-content-center py-1">
                            <div class="pagination">{$PAGINATION}</div>
                        </div>
                    {/if}
                </div>
            </div>
        {/if}
    </div>
</div>