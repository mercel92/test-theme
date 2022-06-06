{if $SETTING.DISPLAY_TITLE}
    <div class="col-12 block-title no-line mb-1">
        {$BLOCK.TITLE}
    </div>
{/if}
<div class="col-12 blog-recent-post{$BLOCK.ID} mb-2">
    <div class="w-100 slider-block-wrapper position-relative">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                {foreach from=$BLOG_POSTS item=B}
                <div class="swiper-slide">
                    <div class="w-100 h-100">
                        <a href="/{$B.URL}" class="image-wrapper mb-1">
                            <span class="image-inner">
                                <img {if $IS_LAZY_LOAD_ACTIVE == '1'}src="{$LAZY_LOAD_LOADING_IMAGE}" data-src="{if $B.IMAGE_URL != ''}{$B.IMAGE_URL}{else}{$B.IMAGE}{/if}" class="lazyload" loading="lazy"{else}src="{if $B.IMAGE_URL != ''}{$B.IMAGE_URL}{else}{$B.IMAGE}{/if}"{/if} alt="{$B.TITLE}">
                            </span>
                        </a>
                        <div class="blog-title">
                            <a class="text-body d-inline-block" href="/{$B.URL}">{$B.TITLE}</a>
                        </div>
                        <div class="mb-1 blog-description text-gray">{$B.TEXT|strip_tags}</div>
                        <div class="w-100">
                            <a href="/{$B.URL}" class="text-primary text-underline">{#read_more#}</a>
                        </div>
                    </div>
                </div>
                {/foreach}
            </div>
        </div>
        <div id="swiper-prev-{$BLOCK.ID}" class="swiper-button-prev outside"><i class="ti-arrow-left"></i></div>
        <div id="swiper-next-{$BLOCK.ID}" class="swiper-button-next outside"><i class="ti-arrow-right"></i></div>
    </div>
</div>