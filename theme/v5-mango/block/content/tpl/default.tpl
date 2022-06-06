<div class="col-12 mb-1">
    <div class="w-100 border border-round border-2x" data-toggle="affix">
        {if $SETTING.DISPLAY_TITLE}
            <div class="text-body text-uppercase fw-bold p-1 d-flex align-items-center" data-toggle="accordion" data-mobile="true">
                {$BLOCK.TITLE}
                <span class="d-block d-md-none ml-auto">
                    <i class="ti-arrow-down"></i>
                    <i class="ti-arrow-up"></i>
                </span>
            </div>
        {/if}
        <nav class="w-100 p-1 pb-0 {if $SETTING.DISPLAY_TITLE}border-top accordion-body{/if}">
            <ul class="clearfix">
                {foreach from=$SETTING.CONTENT_LIST item=CAT}
                    <li class="w-100 pb-1">
                        <a href="/{$CAT.URL}" class="d-block {if $smarty.server.SCRIPT_URL == '/'|cat:$CAT.URL}fw-bold text-primary{else}text-body{/if}">{$CAT.TITLE}</a>
                    </li>
                {/foreach}
            </ul>
        </nav>
    </div>
</div>