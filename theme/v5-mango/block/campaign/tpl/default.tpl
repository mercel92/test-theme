<div class="col-12">
    {if $SETTING.DISPLAY_TITLE}
        <h1 class="block-title mb-2">
            {$BLOCK.TITLE}
        </h1>
    {/if}
    <div class="row">
        {foreach from=$CAMPAIGN_LIST item=C}
        <div class="col-12 col-sm-6 col-md-4 mb-2">
            <div class="w-100 h-100 bg-light">
                <div class="image-wrapper ratio-4x3">
                    <span class="image-inner">
                        <img {if $IS_LAZY_LOAD_ACTIVE == '1'}src="{$LAZY_LOAD_LOADING_IMAGE}" data-src="{$C.IMAGE}" class="lazyload" loading="lazy"{else}src="{$C.IMAGE}"{/if} alt="{$C.TITLE|strip_tags}">
                    </span>
                </div>
                <div class="col-12 py-1">
                    <div class="fw-bold text-primary campaing-title mb-1">{$C.TITLE}</div>
                    <div class="campaing-description mb-1">{$C.DESCRIPTION|strip_tags}</div>
                    <button class="w-100 btn btn-primary set-campaing-{$BLOCK.ID}" data-id="{$C.ID}" data-group="{$C.GROUP}">{#use_this_campaign#}</button>
                </div>
            </div>
        </div>
        {/foreach}
    </div>
</div>
{if $IS_PAGINATION_ACTIVE==1}
    <div class="col-12">
        <div class="col-12 bg-light p-1 mb-4 d-flex justify-content-center align-items-center pagination">{$PAGINATION}</div>
    </div>
{/if}