<div class="col-12">
    <div class="row">
        {if $CATEGORY_LIST|@count > 0}
            <div class="col-12 col-md-3">
                <div class="w-100 bg-white ease border border-2x border-round block-sticky mb-2">
                    <div class="col-12 fw-bold text-uppercase p-1 d-flex align-items-center" data-toggle="accordion" data-mobile="true">
                        {#video_categories#}
                        <span class="d-block d-md-none ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </div>
                    <div class="col-12 border-top accordion-body py-1">
                        <ul class="list-style-none">
                            {foreach from=$CATEGORY_LIST item=C name=category}
                                <li class="w-100{if !$smarty.foreach.category.last} mb-1{/if}">
                                    <a href="{$C.LINK}" class="d-flex {if $C.LINK == $smarty.server.SCRIPT_URI}text-primary{else}text-body{/if}">{$C.NAME}</a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
        {/if}
        {if $GALLERY_LIST|@count > 0}
            <div class="col-12 {if $CATEGORY_LIST|@count > 0}col-md-9{/if}">
                {if $SETTING.DISPLAY_TITLE}
                    <h1 class="w-100 mb-1 block-title">
                        {$BLOCK.TITLE}
                    </h1>
                {/if}
                {if $SETTING.INFO}
                    <div class="w-100 mb-1">
                        {$SETTING.INFO}
                    </div>
                {/if}
                <div class="col-12 p-0">
                    <div class="row">
                        {foreach from=$GALLERY_LIST item=GALLERY}
                            <div class="col-12 col-md-6 mb-2">
                                <div class="w-100 h-100 bg-light">
                                    <a href="/srv/service/content-v5/sub-folder/82/{$BLOCK.PARENT_ID}/video-detail/?video={$GALLERY.ID}"
                                        class="image-wrapper ratio-4x3 popupwin" data-width="1000">
                                        <span class="image-inner">
                                            <img src="{$GALLERY.IMAGE}" alt="{$GALLERY.TITLE}">
                                            <i class="video-play w-100 h-100 d-flex align-items-center justify-content-center ti-youtube-play"></i>
                                        </span>
                                    </a>
                                    <div class="col-12 px-0 py-1">
                                        <div class="col-12">
                                            <a href="/srv/service/content-v5/sub-folder/82/{$BLOCK.PARENT_ID}/video-detail/?video={$GALLERY.ID}"
                                                class="fw-bold text-body popupwin video-title mb-1" data-width="1000">
                                                {$GALLERY.TITLE}
                                            </a>
                                        </div>
                                        <div class="col-12 text-content text-primary fw-600 mb-1 video-category">{$GALLERY.CATEGORY}</div>
                                        <div class="col-12 video-description">{$GALLERY.SUBJECT}</div>
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
                {if $IS_PAGINATION_ACTIVE==1}
                    <div class="col-12 bg-light p-1 mb-4 d-flex justify-content-center align-items-center pagination">{$PAGINATION}</div>
                {/if}
            </div>
        {/if}
    </div>
</div>