<div class="col-12 mb-1 d-flex justify-content-center">
    <div class="col-12 col-md-6 p-1 bg-white border border-light border-round">
        {if $SETTING.DISPLAY_TITLE}
            <div class="w-100 mb-1 block-title border-bottom">
                {$BLOCK.TITLE}
            </div>
        {/if}
        <div class="text-content">
            {if $IS_CANCELLED==true}
                {#dear#} {$MEMBER.NAME} {$MEMBER.SURNAME}, {#cancelled_success#}
            {else}
                {#cancelled_not_found#}
            {/if}
        </div>
    </div>
</div>