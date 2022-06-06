{if $SETTING.IMAGES|@count > 0}
    <div class="w-100 mb-3 slider-padding">
        {if $SETTING.DISPLAY_TITLE}
            <div class="block-title no-line mb-1">{$BLOCK.TITLE}</div>
        {/if}
        <div class="w-100 position-relative slider-block-wrapper">
            <div id="slider-block-{$BLOCK.ID}" class="swiper-container">
                <div class="swiper-wrapper">
                    {foreach from=$SETTING.IMAGES item=IMAGE}
                        <div class="swiper-slide">
                            <a {if $IMAGE.URL != ''}href="{$IMAGE.URL}"{/if} class="w-100 d-flex align-items-center justify-content-center" style="aspect-ratio:{$SETTING.IMAGE_WIDTH_BIG}/{$SETTING.IMAGE_HEIGHT_BIG}">
                                {if $IS_LAZY_LOAD_ACTIVE == '1'}
                                    <img data-src="{$IMAGE.IMG_BIG}" class="swiper-lazy" alt="{$IMAGE.TITLE}">
                                    <div class="swiper-lazy-preloader">
                                        <img src="{$LAZY_LOAD_LOADING_IMAGE}" alt="{$IMAGE.TITLE}" width="50" height="50">
                                    </div>
                                {else}
                                    <img src="{$IMAGE.IMG_BIG}" alt="{$IMAGE.TITLE}">
                                {/if}
                            </a>
                        </div>
                    {/foreach}
                </div>
                {if $SETTING.PAGINATION_TYPE}
                    <div id="swiper-pagination-{$BLOCK.ID}" class="swiper-pagination bottom"></div>
                {/if}
            </div>
            {if $SETTING.DISPLAY_NAVIGATION == 1}
                <div id="swiper-prev-{$BLOCK.ID}" class="swiper-button-prev inside"><i class="ti-arrow-left"></i></div>
                <div id="swiper-next-{$BLOCK.ID}" class="swiper-button-next inside"><i class="ti-arrow-right"></i></div>
            {/if}
        </div>
        {if $SETTING.DISPLAY_THUMBNAIL == 1}
            <div class="w-100 position-relative slider-block-wrapper mt-1">
                <div id="slider-thumb-{$BLOCK.ID}" class="swiper-container">
                    <div class="swiper-wrapper">
                        {foreach from=$SETTING.IMAGES item=IMAGE}
                            <div class="swiper-slide">
                                <div class="w-100 d-flex align-items-center justify-content-center thumb-item border">
                                    {if $IMAGE.IMG_SMALL}
                                        <img src="{$IMAGE.IMG_SMALL}" width="{$SETTING.IMAGE_WIDTH_SMALL}" height="{$SETTING.IMAGE_HEIGHT_SMALL}" alt="{$IMAGE.TITLE} (1)">
                                    {/if}
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        {/if}
    </div>
{/if}