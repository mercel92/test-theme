<header class="container-fluid {if $PAGE_ID !=1}mb-1{/if}">
    <div class="row">
        <div id="header-top-bar" class="w-100 bg-light d-flex align-items-center justify-content-center text-center fw-semibold">
            <i class="ti-order-follow-up mr-1"></i> 200 TL VE ÜZERİ KARGO BEDAVA!
        </div>
        <div id="header-top" class="w-100 d-none d-lg-block border-bottom">
            <div class="container">
                <div class="row align-items-center">
                    {if $DISPLAY_LANGUAGES == 1 || $CURRENCY_LIST|@count > 1}
                    <div class="col-auto pr-0">
                        <div class="dropdown ht-language">
                            <a href="#" class="dropdown-title d-flex align-items-center text-gray" data-toggle="dropdown">
                                <img class="language-img" src="/lang/{$LANGUAGE|lower}/{$LANGUAGE|lower}.png" alt="{$LANGUAGE}" width="16" height="11">
                                {$LANGUAGE} &minus; {$CURRENCY}
                                <i class="ti-arrow-down ml-1"></i>
                            </a>
                            <div class="dropdown-menu border border-bottom-0">
                                {if $DISPLAY_LANGUAGES == 1}
                                <div class="w-100 p-1 border-bottom">
                                    {foreach from=$LANGUAGE_LIST item=LANG}
                                        <a href="#" class="d-flex align-items-center {if $LANGUAGE==$LANG.CODE}text-body active{else}text-gray{/if}" data-language="{$LANG.CODE}" data-toggle="language">
                                            <img src="/lang/{$LANG.CODE|lower}/{$LANG.CODE|lower}.png" alt="{$LANG.TITLE}" width="16" height="11">
                                            {$LANG.TITLE}
                                        </a>
                                    {/foreach}
                                </div>
                                {/if}
                                {if $CURRENCY_LIST|@count > 1}
                                <div class="w-100 p-1 d-flex flex-wrap border-bottom">
                                    {foreach from=$CURRENCY_LIST item=CURRENCY}
                                        <a href="#" class="w-25 d-flex align-items-center {if $CURRENCY.SELECTED==1}text-body active{else}text-gray{/if}" data-currency="{$CURRENCY.TITLE}" data-toggle="language">
                                            {$CURRENCY.TITLE}
                                        </a>
                                    {/foreach}
                                </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                    {/if}
                    <div class="col-auto">
                        <a href="tel:{$CONTACT_INFO|replace:' ':''}" class="d-flex align-items-center text-body">
                            <i class="ti-circle text-light mr-1"></i>
                            <i class="ti-phone"></i>
                           {#customer_support#} : {$CONTACT_INFO}
                        </a>
                    </div>
                    <div class="col-auto ml-auto">
                        <nav id="top-menu" class="d-flex">
                            <ul class="d-flex align-items-center">
                                {if $VISITOR_LOCATION_SERVICE == 1}
                                    <li class="d-flex align-items-center">
                                        <i class="ti-circle text-light"></i>
                                        <a href="/srv/service/content-v5/sub-folder/85/1110/set-store" class="popupwin text-gray location-select" data-width="580">
                                            {if count($VISITOR_LOCATION) > 1}
                                                {foreach $VISITOR_LOCATION as $L}
                                                    {if $L.type != 'U'} {$L.name} {/if}
                                                {/foreach}
                                            {else}
                                                {#location_select#}
                                            {/if}
                                        </a>
                                    </li>
                                {/if}
                                {foreach from=$MENU1 item=M}
                                <li class="d-flex align-items-center">
                                    <i class="ti-circle text-light"></i>
                                    <a href="{$M.URL}" class="text-gray">{$M.NAME}</a>
                                </li>
                                {/foreach}
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <div id="header-main" class="w-100 py-1 py-lg-0">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-auto d-lg-none">
                        <a href="#mobile-menu-{$BLOCK.ID}" data-toggle="drawer" class="header-mobile-menu-btn text-body">
                            <i class="ti-menu"></i>
                        </a>
                    </div>
                    <div class="col-auto col-lg-3 d-flex" id="logo">
                        <a href="{$SITE}">
                            {$SITE_LOGO}
                        </a>
                    </div>
                    <div id="header-search" class="col-12 col-lg-6 order-1 order-lg-0 mt-1 mt-lg-0">
                        <form action="/{url type='page' id='12'}" method="get" autocomplete="off" id="search" class="w-100 position-relative">
                            <div class="d-flex align-items-center h-100 position-relative border px-1 search-skew">
                                <input id="live-search" type="search" name="q" placeholder="{#search_placeholder#}" class="form-control form-control-md border-0 no-cancel"
                                {if $IS_INLINE_SEARCH_ACTIVE == 1}data-search="live-search" v-model="searchVal"{/if} data-licence="{$LICENCE_SEARCH_ALL}">
                                <button type="submit" class="btn" id="live-search-btn"><i class="ti-search"></i></button>
                            </div>
                            {if $IS_INLINE_SEARCH_ACTIVE == 1}
                            <div class="p-1 pb-0 bg-white border border-round search-form-list" id="dynamic-search-{$BLOCK.ID}" v-if="searchVal.length > 0 && data != ''" v-cloak>
                                {if $LICENCE_SEARCH_ALL == 1}
                                    <div class="row dynamic-search">
                                        <div class="col-12 col-sm dynamic-search-item mb-1" v-if="data.products.length > 0">
                                            <div class="block-title border-bottom border-light">{#search_products#}</div>
                                            <ul>
                                                <li v-for="P in data.products">
                                                    <a :href="'/' + P.url">
                                                        <span class="search-image" v-if="P.image"><img :src="P.image" :alt="P.title"></span>
                                                        {{ P.title }}
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-12 col-sm dynamic-search-item mb-1" v-if="data.categories.length > 0">
                                            <div class="block-title border-bottom border-light">{#search_categories#}</div>
                                            <ul>
                                                <li v-for="C in data.categories">
                                                    <a :href="'/' + C.url">
                                                        <span class="search-image" v-if="C.image"><img :src="C.image" :alt="C.title"></span>
                                                        {{ C.title }}
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-12 col-sm dynamic-search-item mb-1" v-if="data.brands.length > 0">
                                            <div class="block-title border-bottom border-light">{#search_brands#}</div>
                                            <ul>
                                                <li v-for="B in data.brands">
                                                    <a :href="'/' + B.url">
                                                        <span class="search-image" v-if="B.image"><img :src="B.image" :alt="B.title"></span>
                                                        {{ B.title }}
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="col-12 col-sm dynamic-search-item" v-if="data.combines.length > 0">
                                            <div class="block-title border-bottom border-light">{#search_combins#}</div>
                                            <ul>
                                                <li v-for="C in data.combines">
                                                    <a :href="'/' + C.url">
                                                        <span class="search-image" v-if="C.image"><img :src="C.image" :alt="C.title"></span>
                                                        {{ C.title }}
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="dynamic-search-item px-1 mb-1" v-if="data.products.length < 1 && data.categories.length < 1 && data.brands.length < 1 && data.combines.length < 1">
                                            {#no_result#}
                                        </div>
                                    </div>
                                {else}
                                    <div class="w-100 dynamic-search mb-1" v-html="data"></div>
                                {/if}
                            </div>
                            {/if}
                        </form>
                    </div>
                    <div id="hm-links" class="col-auto col-lg-3 ml-auto pl-0">
                        <div class="w-100 position-relative hm-links">
                            <div class="row align-items-center justify-content-evenly h-100">
                                <div class="col-auto">
                                    <a href="/{url type='page' id='35'}" class="text-body" id="header-favourite-count">
                                        <i class="ti-heart-o"></i>
                                    </a>
                                </div>
                                <div class="col-auto">
                                    {if $IS_MEMBER_LOGGED_IN == true}
                                        <a href="/{url type='page' id='5'}" class="text-body" id="header-account">
                                            <i class="ti-user"></i>
                                        </a>
                                        {else}
                                        <a href="#header-member-panel-{$BLOCK.ID}" data-toggle="drawer" class="text-body" id="header-account">
                                            <i class="ti-user"></i>
                                        </a>
                                    {/if}
                                </div>
                                <div class="col-auto">
                                    <a href="#header-cart-panel-{$BLOCK.ID}" data-toggle="drawer" id="header-cart-count">
                                        <i class="ti-basket-outline position-relative text-primary"><span class="badge bg-black text-white cart-soft-count">0</span></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="header-menu" class="w-100 d-none d-lg-block bg-secondary">
            <div class="container">
                {if $TABS|@count > 0}
                    <nav id="main-menu" class="w-100 position-relative">
                        <ul class="row align-items-center justify-content-center menu">
                            {foreach from=$TABS item=M}
                            <li>
                                <a href="{$M.URL}" class="px-2 text-white d-flex align-items-center text-center text-uppercase fw-bold" title="{$M.NAME}">{$M.NAME}</a>
                                {if $M.CHILDREN|@count > 0}
                                    <div class="w-100 px-1 sub-menu ease">
                                        <div class="row">
                                            <div class="{if $M.IMAGE}col-8{else}col-12{/if} p-2">
                                                <div class="row">
                                                    {foreach from=$M.CHILDREN item=SUB}
                                                        <div class="{if $M.IMAGE}col-3{else}col-2{/if} mb-2">
                                                            <a href="{$SUB.URL}" class="menu-title d-inline-block text-body" title="{$SUB.NAME}">
                                                                {$SUB.NAME}
                                                            </a>
                                                            {if $SUB.CHILDREN|@count > 0}
                                                                <ul class="w-100 d-block mt-1">
                                                                    {foreach from=$SUB.CHILDREN item=CHILD name="SUB_CHILDREN"}
                                                                    {if $smarty.foreach.SUB_CHILDREN.iteration < 9}
                                                                        <li class="w-100">
                                                                            <a href="{$CHILD.URL}" class="d-inline-block text-gray" title="{$CHILD.NAME}">{$CHILD.NAME}</a>
                                                                        </li>
                                                                    {/if}
                                                                    {/foreach}
                                                                    {if $SUB.CHILDREN|@count > 8}
                                                                        <li class="w-100">
                                                                            <a href="{$SUB.URL}" class="text-primary text-underline d-inline-block" title="{#products#}">{#products#}</a>
                                                                        </li>
                                                                    {/if}
                                                                </ul>
                                                            {/if}
                                                        </div>
                                                    {/foreach}
                                                </div>
                                            </div>
                                            {if $M.IMAGE}
                                                <div class="col-4 p-1 border-left border-light d-flex align-items-center justify-content-center">
                                                    <a href="{$M.URL}" class="d-flex align-items-center">
                                                        <img src="{$M.IMAGE}" title="{$M.NAME}">
                                                    </a>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                {/if}
                            </li>
                            {/foreach}
                        </ul>
                    </nav>
                {/if}
            </div>
        </div>
    </div>
</header>

<div data-rel="mobile-menu-{$BLOCK.ID}" class="drawer-overlay"></div>
<div id="mobile-menu-{$BLOCK.ID}" class="drawer-wrapper" data-display="overlay" data-position="left">
    <div class="drawer-title">
        <span>{#menu#}</span>
        <div class="drawer-close">
            <i class="ti-close"></i>
        </div>
    </div>
    <div class="w-100 border-top">
        <nav class="w-100 clearfix">
            <ul class="w-100 clearfix">
                {foreach from=$TABS item=M}
                <li class="w-100 border-bottom">
                    {if $M.CHILDREN|@count > 0}
                    <div class="col-12 d-flex align-items-center text-body px-2 menu-first-item" data-toggle="accordion">
                        {$M.NAME}
                        <span class="ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </div>
                    <div class="accordion-body clearfix">
                        <ul class="col-12 clearfix px-3 pb-2">
                            {foreach from=$M.CHILDREN item=SUB name=SUB}
                            <li class="w-100 mb-1">
                                <a href="{$SUB.URL}" class="d-block menu-secondary-item text-gray" title="{$SUB.NAME}">{$SUB.NAME}</a>
                            </li>
                            {/foreach}
                            <li class="w-100">
                                <a href="{$M.URL}" class="d-block menu-secondary-item text-primary" title="Tümünü Gör">Tümünü Gör</a>
                            </li>
                        </ul>
                    </div>
                    {else}
                    <a href="{$M.URL}" class="col-12 d-flex align-items-center text-body px-2 menu-first-item" title="{$M.NAME}">{$M.NAME}</a>
                    {/if}
                </li>
                {/foreach}
            </ul>
        </nav>
        <nav class="w-100 bg-light clearfix">
            <ul class="w-100 clearfix">
                {if $VISITOR_LOCATION_SERVICE == 1}
                    <li class="w-100 border-bottom">
                        <a href="/srv/service/content-v5/sub-folder/85/1110/set-store" class="popupwin col-12 d-flex align-items-center text-body px-2 menu-first-item" data-width="580">
                        {if count($VISITOR_LOCATION) > 1}
                            {foreach $VISITOR_LOCATION as $L}
                                {if $L.type != 'U'} {$L.name} {/if}
                            {/foreach}
                        {else}
                            {#location_select#}
                        {/if}
                        </a>
                    </li>
                {/if}
                {foreach from=$MENU1 item=M}
                <li class="w-100 border-bottom">
                    <a href="{$M.URL}" class="col-12 d-flex align-items-center text-body px-2 menu-first-item">{$M.NAME}</a>
                </li>
                {/foreach}
                {if $DISPLAY_LANGUAGES == 1 || $CURRENCY_LIST|@count > 1}
                    <li class="w-100 border-bottom">
                        <div class="mobile-language">
                            <div class="col-12 d-flex align-items-center text-body px-2 menu-first-item" data-toggle="accordion">
                                <img class="mr-1" src="/lang/{$LANGUAGE|lower}/{$LANGUAGE|lower}.png" alt="{$LANGUAGE}" width="16" height="11">
                                {$LANGUAGE} &minus; {$CURRENCY}
                                <span class="ml-auto">
                                    <i class="ti-arrow-down"></i>
                                    <i class="ti-arrow-up"></i>
                                </span>
                            </div>
                            <div class="accordion-body border-top p-2 bg-white">
                                <div class="mobile-language-title fw-bold mb-1">Dil & Para Birimi Seçiniz</div>
                                {if $DISPLAY_LANGUAGES == 1}
                                    <select class="form-control mb-1" data-toggle="language">
                                        {foreach from=$LANGUAGE_LIST item=LANG}
                                        <option {if $LANGUAGE==$LANG.CODE}selected{/if} value="{$LANG.CODE}">
                                            {$LANG.TITLE}</option>
                                        {/foreach}
                                    </select>
                                {/if}
                                {if $CURRENCY_LIST|@count > 1}
                                    <select class="form-control" data-toggle="currency">
                                        {foreach from=$CURRENCY_LIST item=CURRENCY}
                                        <option {if $CURRENCY.SELECTED==1}selected{/if} value="{$CURRENCY.TITLE}">{$CURRENCY.TITLE}</option>
                                        {/foreach}
                                    </select>
                                {/if}
                            </div>
                        </div>
                    </li>
                {/if}                
            </ul>
        </nav>
    </div>
</div>
{if $IS_MEMBER_LOGGED_IN != true}
<div data-rel="header-member-panel-{$BLOCK.ID}" class="drawer-overlay"></div>
<div id="header-member-panel-{$BLOCK.ID}" class="drawer-wrapper" data-display="overlay" data-position="right">
    <div class="drawer-title">
        <span>{#account#}</span>
        <div class="drawer-close">
            <i class="ti-close"></i>
        </div>
    </div>
    <div class="drawer-body">
        <form action="#" method="POST" class="w-100" data-toggle="login-form" data-prefix="header-" data-callback="headerMemberLoginFn" novalidate>
            <div class="row">
                <div class="col-12">
                    <ul id="header-login-type" class="tab-nav list-style-none">
                        <li class="active" data-type="email"><a href="#header-login" data-toggle="tab">{#member_login#}</a></li>
                        <li><a href="/{url type='page' id='6'}">{#register#}</a></li>
                        {if $LICENCE_REGISTRATION_WITH_PHONE == 1}
                            <li data-type="phone"><a href="#header-login-with-phone" data-toggle="tab">{#phone_login#}</a></li>
                        {/if}
                    </ul>
                </div>
                <div class="col-12 mb-1 tab-content">
                    <div id="header-login" class="w-100 tab-pane active">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="email" id="header-email" class="form-control" placeholder="{#enter_email#}">
                        </div>
                    </div>
                    {if $LICENCE_REGISTRATION_WITH_PHONE == 1}
                    <div id="header-login-with-phone" class="w-100 tab-pane">
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="tel" id="header-phone" class="form-control" data-flag-masked placeholder="{#enter_phone_number#}">
                        </div>
                    </div>
                    {/if}
                </div>
                <div class="col-12 mb-1">
                    <input type="password" id="header-password" class="form-control" placeholder="{#enter_password#}">
                </div>                    
                <div class="col-12 d-flex flex-wrap justify-content-between">
                    <input type="checkbox" id="header-remember" name="header-remember" class="form-control">
                    <label for="header-remember" class="mb-1 d-flex align-items-center fw-regular">
                        <span class="input-checkbox">
                            <i class="ti-check"></i>
                        </span>
                        {#remember_me#}
                    </label>
                    <a href="/{url type='page' id='7'}" class="text-gray text-underline mb-1">{#forgot_password#}</a>
                </div>
                <div class="col-12 mb-1">
                    <button type="submit" class="w-100 d-flex align-items-center justify-content-between btn btn-md btn-primary text-uppercase">
                        {#login#}
                        <i class="ti-arrow-right"></i>
                    </button>
                </div>
                {if $DISPLAY_FACEBOOK == 1 || $DISPLAY_GOOGLE == 1 || $DISPLAY_APPLE == 1}
                    <div class="col-12">
                        <div class="row">
                        {if $DISPLAY_FACEBOOK == 1}
                            <div class="col-6 mb-1">
                                <a href="/srv/service/social/facebook/login" class="btn btn-md fb-login-btn">
                                    <i class="ti-facebook"></i> {#connect_with#}
                                </a>
                            </div>
                        {/if}
                        {if $DISPLAY_GOOGLE == 1}
                            <div class="col-6 mb-1">
                                <a id="signinGoogle" href="javascript:void(0)" class="btn btn-md google-login-btn">
                                    <i class="ti-google"></i> {#connect_with#}
                                </a>
                            </div>
                        {/if}
                        {if $DISPLAY_APPLE == 1}
                            <div class="col-6 mb-1">
                                <a href="/api/v1/authentication/social-login?type=apple&ajax=1" class="btn btn-md apple-login-btn">
                                    <i class="ti-apple"></i> {#connect_with#}
                                </a>
                            </div>
                        {/if}
                        </div>
                    </div>
                {/if}
            </div>
        </form>
    </div>
</div>
{/if}
<div data-rel="header-cart-panel-{$BLOCK.ID}" class="drawer-overlay"></div>
<div id="header-cart-panel-{$BLOCK.ID}" class="drawer-wrapper" data-display="overlay" data-position="right" data-callback="headercart-cb-{$BLOCK.ID}">
    <div class="drawer-title">
        <span>{#cart#}</span>
        <div class="drawer-close">
            <i class="ti-close"></i>
        </div>
    </div>
    <div class="drawer-body"></div>
</div>
<div class="bg-primary text-white text-center border border-white scroll-to-up" id="scroll-to-up-{$BLOCK.ID}">
    <i class="ti-arrow-up"></i>
</div>