<div class="col-12 mb-2">
    {if $SETTING.DISPLAY_TITLE}
        <div class="block-title fw-regular no-line mb-1">
            {$BLOCK.TITLE}
        </div>
    {/if}
    <div class="row">
        {foreach from=$CATEGORIES item=CATEGORY}
        <div class="col-auto mb-1">
            <a href="{$CATEGORY.URL}" class="text-body btn btn-outline-light h-100">
                {$CATEGORY.NAME}
            </a>
        </div>
        {/foreach}
    </div>
</div>