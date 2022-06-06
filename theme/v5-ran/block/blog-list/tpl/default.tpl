<div class="col-12">
    <div class="row">
        {foreach from=$BLOG_POSTS item=B}
        <div class="col-12 col-sm-6 mb-2">
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
{if $IS_PAGINATION_ACTIVE==1}
    <div class="col-12 mb-2">
        <div class="row align-items-center">
            <div class="col-12 col-md-auto ml-auto d-flex justify-content-center py-1">
                <div class="pagination">{$PAGINATION}</div>
            </div>
        </div>
    </div>
{/if}