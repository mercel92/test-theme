<div class="col-12">
    {if $SETTING.DISPLAY_TITLE}
        <div class="block-title mb-2">{$BLOCK.TITLE}</div>
    {/if}
    <div class="row">
        {foreach from=$SETTING.IMAGES item=IMAGE}
            <div class="col-{$IMAGE.COL.ALL} col-sm-{$IMAGE.COL.SM} col-md-{$IMAGE.COL.MD} col-lg-{$IMAGE.COL.LG} col-xl-{$IMAGE.COL.XL} mb-2">
                <a href="{$IMAGE.URL}" class="d-block">
                    {if $IMAGE.IMG_BIG || $IMAGE.IMG_SMALL}
                        <picture class="d-flex align-items-center">
                            {if $IMAGE.IMG_BIG && $IMAGE.IMG_SMALL}
                                <source media="(min-width:576px)" srcset="{$IMAGE.IMG_BIG}">
                                <img {if $IS_LAZY_LOAD_ACTIVE == '1'} src="{$LAZY_LOAD_LOADING_IMAGE}" data-src="{$IMAGE.IMG_SMALL}" class="lazyload" loading="lazy"{else} src="{$IMAGE.IMG_SMALL}"{/if} 
                                    width="{$IMAGE.IMAGE_WIDTH_DESKTOP}" height="{$IMAGE.IMAGE_HEIGHT_DESKTOP}" alt="{$IMAGE.TITLE}">
                            {else}
                                <img {if $IS_LAZY_LOAD_ACTIVE == '1'} src="{$LAZY_LOAD_LOADING_IMAGE}" data-src="{$IMAGE.IMG_BIG}" class="lazyload" loading="lazy"{else} src="{$IMAGE.IMG_BIG}"{/if} 
                                    width="{$IMAGE.IMAGE_WIDTH_DESKTOP}" height="{$IMAGE.IMAGE_HEIGHT_DESKTOP}" alt="{$IMAGE.TITLE}">
                            {/if}
                        </picture>
                    {/if}
                </a>
            </div>
        {/foreach}
    </div>
</div>