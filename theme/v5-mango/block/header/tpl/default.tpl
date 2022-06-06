<header class="container-fluid">
    <div class="row">
        <div id="header-top" class="container-fluid bg-light d-none d-lg-block">
            <div class="row">
                <div class="container">
                    <div class="row">
                        {if $DISPLAY_LANGUAGES == 1 || $CURRENCY_LIST|@count > 1}
                        <div class="col-5">
                            <div class="d-flex border-left">
                                <div class="dropdown border-right">
                                    <a href="#" class="dropdown-title d-flex align-items-center px-1" data-toggle="dropdown">
                                        <img class="language-img" src="/lang/{$LANGUAGE|lower}/{$LANGUAGE|lower}.png" alt="{$LANGUAGE}" width="16" height="11">
                                        {$LANGUAGE|upper} &minus; {$CURRENCY|upper}
                                        <i class="ti-arrow-down ml-1"></i>
                                    </a>
                                    <div class="dropdown-menu">
                                        {if $DISPLAY_LANGUAGES == 1}
                                        <div class="w-100 mb-1">
                                            <label for="site-language-select">{#language#}</label>
                                            <select id="site-language-select" class="form-control" data-toggle="language">
                                                {foreach from=$LANGUAGE_LIST item=LANG}
                                                <option {if $LANGUAGE==$LANG.CODE}selected{/if} value="{$LANG.CODE}">
                                                    {$LANG.TITLE}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        {/if}
                                        {if $CURRENCY_LIST|@count > 1}
                                        <div class="w-100 mb-1">
                                            <label for="site-currency-select">{#currency#}</label>
                                            <select id="site-currency-select" class="form-control" data-toggle="currency">
                                                {foreach from=$CURRENCY_LIST item=CURRENCY}
                                                <option {if $CURRENCY.SELECTED==1}selected{/if} value="{$CURRENCY.TITLE}">{$CURRENCY.TITLE}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        {/if}
                                    </div>
                                </div>
                                <a href="tel:{$CONTACT_INFO|replace:' ':''}" class="px-1 border-right">
                                    <i class="ti-volume-phone text-primary"></i>
                                    <strong class="text-uppercase">{#customer_support#} : </strong>{$CONTACT_INFO}
                                </a>
                            </div>
                        </div>
                        {/if}
                        <div class="col-7">
                            <nav id="top-menu" class="d-flex border-right">
                                <ul class="ml-auto d-flex flex-wrap">
                                    {if $VISITOR_LOCATION_SERVICE == 1}
                                        <li class="border-left px-1">
                                            <a href="/srv/service/content-v5/sub-folder/85/1110/set-store" class="popupwin location-select" data-width="580">
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
                                    <li class="border-left px-1"><a href="{$M.URL}">{$M.NAME}</a></li>
                                    {/foreach}
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="header-main" class="container p-1">
            <div class="row align-items-center">
                <div class="col-4 d-lg-none">
                    <a href="#mobile-menu-{$BLOCK.ID}" data-toggle="drawer" class="header-mobile-menu-btn">
                        <i class="ti-menu text-primary"></i>
                    </a>
                </div>
                <div class="col-4 col-lg-3 d-flex">
                    <a href="{$SITE}" id="logo">
                        {$SITE_LOGO}
                    </a>
                </div>
                <div id="header-search" class="col-12 col-lg-4 offset-lg-1">
                    <form action="/{url type='page' id='12'}" method="get" autocomplete="off" id="search" class="w-100 position-relative">
                        <input id="live-search" type="search" name="q" placeholder="{#search_placeholder#}" class="form-control form-control-md"
                        {if $IS_INLINE_SEARCH_ACTIVE == 1}data-search="live-search" v-model="searchVal"{/if} data-licence="{$LICENCE_SEARCH_ALL}">
                        <button type="submit" class="btn btn-dark" id="live-search-btn">{#search#}</button>
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
                <div id="hm-links" class="col-4">
                    <div class="row justify-content-flex-end">
                        <a href="/{url type='page' id='35'}" class="px-1" id="header-favourite-count">
                            <i class="ti-heart-o"><span class="tsoft-favourite-count customer-favorites-count badge">0</span></i>
                            <span class="d-none d-lg-block text-body">{#favorites#}</span>
                        </a>
                        {if $IS_MEMBER_LOGGED_IN == true}
                        <a href="/{url type='page' id='5'}" class="px-1" id="header-account">
                            <i class="ti-user"></i>
                            <span class="d-none d-lg-block text-body">{#account#}</span>
                        </a>
                        {else}
                        <a href="#header-member-panel-{$BLOCK.ID}" data-toggle="drawer" class="px-1" id="header-account">
                            <i class="ti-user"></i>
                            <span class="d-none d-lg-block text-body">{#account#}</span>
                        </a>
                        {/if}
                        <a href="#header-cart-panel-{$BLOCK.ID}" data-toggle="drawer" class="px-1" id="header-cart-count">
                            <i class="ti-basket-outline text-primary"><span class="badge cart-soft-count">0</span></i>
                            <span class="d-none d-lg-block text-body">{#cart#}</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        {if $MENU2|@count > 0}
        <nav id="header-menu" class="container-fluid px-0 border-bottom d-none d-lg-block">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <ul class="w-100 d-flex menu">
                            <li class="d-flex align-items-center">
                                <a href="{$SITE}" class="d-block px-1 homepage-link">
                                    <i class="ti-homepage text-primary"></i>
                                </a>
                            </li>
                            {foreach from=$MENU2 item=M2}
                            <li class="d-flex align-items-center">
                                <a href="{$M2.URL}" class="d-block px-1">{$M2.NAME}</a>
                            </li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        {/if}
        {if $TABS|@count > 0}
        <nav id="main-menu" class="container-fluid px-0 border-bottom mb-1 d-none d-lg-block">
            <div class="container">
                <ul class="d-flex position-relative menu">
                    <li id="menu-all-categories-{$BLOCK.ID}" class="menu-all-categories">
                        <a href="javascript:void(0);" class="d-flex align-items-center h-100 w-100 px-1 text-uppercase fw-bold" @mouseover.once="get()">
                            <i class="ti-menu text-primary"></i>
                            {#categories#}
                        </a>
                        <div class="w-100 sub-menu" v-cloak>
                            <ul class="bg-white border-right border-light py-1 sub-menu-scroll" v-if="!LOAD">
                                <li class="w-100" v-for="(CAT, index) in CATEGORIES" @mouseover.once="get(CAT.ID)">
                                    <a :href="'/' + CAT.LINK" class="d-flex fw-semibold" :data-cat-id="CAT.ID" :title="CAT.TITLE">{{ CAT.TITLE }}</a>
                                    <div class="sub-menu-child" v-if="typeof(CAT.CHILDREN) != 'undefined'">
                                        <ul class="bg-white border-right border-light sub-menu-scroll py-1" v-if="CAT.CHILDREN.length > 0">
                                            <li class="w-100" v-for="SUB in CAT.CHILDREN" @mouseover.once="get(SUB.ID, CAT.ID)">
                                                <a :href="'/' + SUB.LINK" class="d-flex" :title="SUB.TITLE">{{ SUB.TITLE }}</a>
                                                <div class="sub-menu-child" v-if="typeof(SUB.CHILDREN) != 'undefined' && (SUB.CHILDREN.length > 0 || SUB.IMAGE != '')">
                                                    <ul class="bg-white border-right border-light sub-menu-scroll py-1" v-if="SUB.CHILDREN.length > 0">
                                                        <li class="w-100" v-for="SUB2 in SUB.CHILDREN">
                                                            <a :href="'/' + SUB2.LINK" class="d-flex" :title="SUB2.TITLE">{{ SUB2.TITLE }}</a>
                                                        </li>
                                                    </ul>
                                                    <div class="col d-flex align-items-center justify-content-center bg-white p-1" v-if="SUB.IMAGE != ''">
                                                        <a :href="'/' + SUB.LINK" class="text-center">
                                                            <img :src="SUB.IMAGE" :alt="SUB.TITLE">
                                                            <span class="d-block fw-bold mt-1" :title="SUB.TITLE">{{ SUB.TITLE }}</span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="col d-flex align-items-center justify-content-center bg-white p-1" v-if="CAT.IMAGE != ''">
                                            <a :href="'/' + CAT.LINK" class="text-center" :title="CAT.TITLE">
                                                <img :src="CAT.IMAGE" :alt="CAT.TITLE">
                                                <span class="d-block fw-bold mt-1">{{ CAT.TITLE }}</span>
                                            </a>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </li>
                    {foreach from=$TABS item=M}
                    <li>
                        <a href="{$M.URL}" class="d-flex align-items-center h-100 w-100 px-1 text-center text-uppercase" title="{$M.NAME}">{$M.NAME}</a>
                        {if $M.CHILDREN|@count > 0}
                            <div class="w-100 p-2 sub-menu">
                                <div class="row">
                                    {foreach from=$M.CHILDREN item=SUB}
                                        <div class="col-2">
                                            <a href="{$SUB.URL}" class="fw-semibold menu-title d-inline-block" title="{$SUB.NAME}">
                                                {$SUB.NAME}
                                            </a>
                                            {if $SUB.CHILDREN|@count > 0}
                                                <ul class="clearfix mb-1">
                                                    {foreach from=$SUB.CHILDREN item=CHILD name="SUB_CHILDREN"}
                                                    {if $smarty.foreach.SUB_CHILDREN.iteration < 6}
                                                        <li class="w-100">
                                                            <a href="{$CHILD.URL}" class="d-inline-block" title="{$CHILD.NAME}">{$CHILD.NAME}</a>
                                                        </li>
                                                    {/if}
                                                    {/foreach}
                                                    {if $SUB.CHILDREN|@count > 5}
                                                        <li class="w-100">
                                                            <a href="{$SUB.URL}" class="text-primary d-inline-block" title="{#products#}">{#products#}</a>
                                                        </li>
                                                    {/if}
                                                </ul>
                                            {/if}
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        {/if}
                    </li>
                    {/foreach}
                </ul>
            </div>
        </nav>
        {/if}
    </div>
</header>

<div data-rel="mobile-menu-{$BLOCK.ID}" class="drawer-overlay"></div>
<div id="mobile-menu-{$BLOCK.ID}" class="drawer-wrapper" data-display="overlay" data-position="left">
    <div class="w-100">
        <div class="col-12 fw-bold text-uppercase mobile-menu-title">{#menu#}</div>
        <nav class="col-12">
            <ul class="w-100 clearfix">
                {foreach from=$TABS item=M}
                <li class="w-100 border-bottom">
                    {if $M.CHILDREN|@count > 0}
                    <div class="d-block fw-bold text-uppercase menu-item" data-toggle="accordion">
                        {$M.NAME}
                        <span>
                            <i class="ti-plus"></i>
                            <i class="ti-minus"></i>
                        </span>
                    </div>
                    <div class="clearfix border-top accordion-body">
                        <ul class="w-100 px-1">
                            {foreach from=$M.CHILDREN item=SUB name=SUB}
                            <li class="w-100 border-bottom">
                                {if $SUB.CHILDREN|@count > 0}
                                <div class="d-block fw-bold text-uppercase menu-item" data-toggle="accordion">
                                    {$SUB.NAME}
                                    <span>
                                        <i class="ti-plus"></i>
                                        <i class="ti-minus"></i>
                                    </span>
                                </div>
                                <div class="clearfix border-top accordion-body">
                                    <ul class="w-100 px-1">
                                        {foreach from=$SUB.CHILDREN item=SUB2 name=SUB2}
                                        <li class="w-100 border-bottom">
                                            <a href="{$SUB2.URL}" class="d-block fw-bold text-uppercase" title="{$SUB2.NAME}">{$SUB2.NAME}</a>
                                        </li>
                                        {/foreach}
                                        <li class="w-100">
                                            <a href="{$SUB.URL}" class="d-block fw-bold text-uppercase text-primary" title="Tümünü Gör">Tümünü Gör</a>
                                        </li>
                                    </ul>
                                </div>
                                {else}
                                <a href="{$SUB.URL}" class="d-block fw-bold text-uppercase" title="{$SUB.NAME}">{$SUB.NAME}</a>
                                {/if}
                            </li>
                            {/foreach}
                            <li class="w-100">
                                <a href="{$M.URL}" class="d-block fw-bold text-uppercase text-primary" title="Tümünü Gör">Tümünü Gör</a>
                            </li>
                        </ul>
                    </div>
                    {else}
                    <a href="{$M.URL}" class="d-block fw-bold text-uppercase" title="{$M.NAME}">{$M.NAME}</a>
                    {/if}
                </li>
                {/foreach}
            </ul>
        </nav>
        <nav class="w-100 nav bg-light">
            <ul class="w-100 clearfix">
                {foreach from=$MENU1 item=M}
                <li class="w-100 border-bottom px-2"><a href="{$M.URL}" class="d-block fw-semibold menu-item">{$M.NAME}</a></li>
                {/foreach}
                {if $VISITOR_LOCATION_SERVICE == 1}
                    <li class="w-100 border-bottom bg-primary px-2">
                        <a href="/srv/service/content-v5/sub-folder/85/1110/set-store" class="popupwin d-block fw-semibold text-white menu-item" data-width="580">
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
            </ul>
        </nav>
    </div>
</div>

{if $IS_MEMBER_LOGGED_IN != true}
<div data-rel="header-member-panel-{$BLOCK.ID}" class="drawer-overlay"></div>
<div id="header-member-panel-{$BLOCK.ID}" class="drawer-wrapper" data-display="overlay" data-position="right">
    <div class="drawer-close d-inline-flex">
        <span class="d-md-none">{#close#}</span>
        <i class="ti-close"></i>
    </div>
    <div class="drawer-title clearfix">
        <i class="ti-user"></i>
        <span>{#account#}</span>
    </div>
    <div class="drawer-body">
        <form action="#" method="POST" class="col-12" data-toggle="login-form" data-prefix="header-" data-callback="headerMemberLoginFn" novalidate>
            <div class="row">
                <div class="col-12 p-0">
                    <ul id="header-login-type" class="tab-nav list-style-none">
                        <li class="active" data-type="email"><a href="#header-login" data-toggle="tab">{#member_login#}</a></li>
                        {if $LICENCE_REGISTRATION_WITH_PHONE == 1}
                            <li data-type="phone"><a href="#header-login-with-phone" data-toggle="tab">{#phone_login#}</a></li>
                        {/if}
                    </ul>
                </div>
                <div class="col-12 px-0 mb-1 tab-content">
                    <div id="header-login" class="w-100 tab-pane active">
                        <label for="header-email">{#username_email#}</label>
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="email" id="header-email" class="form-control" placeholder="{#enter_email#}">
                        </div>
                    </div>
                    {if $LICENCE_REGISTRATION_WITH_PHONE == 1}
                    <div id="header-login-with-phone" class="w-100 tab-pane">
                        <label for="header-phone">{#phone_number#}</label>
                        <div class="w-100 popover-wrapper position-relative">
                            <input type="tel" id="header-phone" class="form-control" data-flag-masked placeholder="{#enter_phone_number#}">
                        </div>
                    </div>
                    {/if}
                </div>
                <div class="col-12 px-0 mb-1">
                    <label for="header-password">{#password#}</label>
                    <input type="password" id="header-password" class="form-control" placeholder="{#enter_password#}">
                </div>                    
                <div class="col-12 px-0 d-flex flex-wrap justify-content-between">
                    <input type="checkbox" id="header-remember" name="header-remember" class="form-control">
                    <label for="header-remember" class="mb-1 d-flex align-items-center">
                        <span class="input-checkbox">
                            <i class="ti-check"></i>
                        </span>
                        {#remember_me#}
                    </label>
                    <a href="/{url type='page' id='7'}" class="text-body mb-1">{#forgot_password#}</a>
                </div>
                <div class="col-12 px-0 mb-1">
                    <button type="submit" class="w-100 btn btn-primary text-uppercase">{#login#}</button>
                </div>
                <div class="col-12 px-0 mb-1">
                    <a href="/{url type='page' id='6'}" class="w-100 btn btn-dark text-uppercase text-center">{#register#}</a>
                </div>
                {if $DISPLAY_FACEBOOK == 1 || $DISPLAY_GOOGLE == 1 || $DISPLAY_APPLE == 1}
                    <div class="col-12 pl-0">
                        <div class="row">
                            {if $DISPLAY_FACEBOOK == 1}
                            <div class="col-6 pr-0 pb-1">
                                <a href="/srv/service/social/facebook/login" class="fb-login-btn">
                                    <i class="ti-facebook"></i> {#connect_with#}
                                </a>
                            </div>
                            {/if}
                            {if $DISPLAY_GOOGLE == 1}
                            <div class="col-6 pr-0 pb-1">
                                <a id="signinGoogle" href="javascript:void(0)" class="google-login-btn">
                                    <i class="ti-google"></i> {#connect_with#}
                                </a>
                            </div>
                            {/if}
                            {if $DISPLAY_APPLE == 1}
                            <div class="col-6 pr-0 pb-1">
                                <a href="/api/v1/authentication/social-login?type=apple&ajax=1" class="apple-login-btn">
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
    <div class="drawer-close d-inline-flex">
        <span class="d-md-none">{#close#}</span>
        <i class="ti-close"></i>
    </div>
    <div class="drawer-title clearfix">
        <i class="ti-basket-outline"></i>
        <span>{#cart#}</span>
    </div>
    <div class="drawer-body"></div>
</div>

<div class="bg-primary text-white text-center border border-white scroll-to-up" id="scroll-to-up-{$BLOCK.ID}">
    <i class="ti-arrow-up"></i>
</div>