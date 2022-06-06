<div class="col-12 blog-categories mb-2">
    <div class="w-100 bg-white border" data-toggle="affix">
        {if $SETTING.DISPLAY_TITLE}
            <div class="col-12 p-1 d-flex align-items-center accordion-title active" data-toggle="accordion">
                {$BLOCK.TITLE}
                <span class="ml-auto">
                    <i class="ti-arrow-down"></i>
                    <i class="ti-arrow-up"></i>
                </span>
            </div>
        {/if}
        <div class="col-12 {if $SETTING.DISPLAY_TITLE}accordion-body active{/if}">
            <ul class="list-style-none">
                {foreach from=$CATEGORIES item=C name=category}
                    <li class="w-100 mb-1">
                        <a href="/{$C.URL}" class="d-flex {if $smarty.server.SCRIPT_URL == '/'|cat:$C.URL}text-primary{else}text-gray{/if}">{$C.NAME}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </div>
</div>