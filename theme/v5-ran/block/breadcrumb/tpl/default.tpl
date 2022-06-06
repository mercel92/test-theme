<nav class="col-12 mb-1 breadcrumb">
    <ul class="clearfix list-type-none">
        <li class="d-inline-flex align-items-center">
            <a href="{$SITE}" class="d-flex align-items-center">
                <i class="ti-location"></i>
                {#home#}
            </a>
        </li>
        {foreach from=$NAVIGATION_LIST item=NAV}
            <li class="d-inline-flex align-items-center">
                <i class="ti-arrow-right"></i>
                <a {if $NAV.LINK != ''}href="{$SITE}{$NAV.LINK}"{else}href="javascript:void(0)"{/if} title="{$NAV.TITLE}">{$NAV.TITLE}</a>
            </li>
        {/foreach}
    </ul>
</nav>