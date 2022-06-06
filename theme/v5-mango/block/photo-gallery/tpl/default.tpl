<div class="col-12">
    <div class="row">
        {if $CATEGORY_LIST|@count > 0}
            <div class="col-12 col-md-3">
                <div class="w-100 bg-white ease border border-2x border-round block-sticky mb-2">
                    <div class="col-12 fw-bold text-uppercase p-1 d-flex align-items-center" data-toggle="accordion" data-mobile="true">
                        {#photo_gallery_categories#}
                        <span class="d-block d-md-none ml-auto">
                            <i class="ti-arrow-down"></i>
                            <i class="ti-arrow-up"></i>
                        </span>
                    </div>
                    <div class="col-12 border-top accordion-body py-1">
                        <ul class="list-style-none">
                            {foreach from=$CATEGORY_LIST item=C name=category}
                                <li class="w-100{if !$smarty.foreach.category.last} mb-1{/if}">
                                    <a href="{$C.LINK}"
                                class="d-flex {if $C.LINK|replace:$smarty.server.SCRIPT_URI:''|replace:'?':'' == $smarty.server.QUERY_STRING}text-primary{else}text-body{/if}">{$C.NAME}</a>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
        {/if}
        <div class="col-12{if $CATEGORY_LIST|@count > 0} col-md-9{/if}">
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
                    {foreach from=$GALLERY_LIST item=G}
                        <div class="col-12 col-md-6 mb-2">
                            <div class="w-100 h-100 bg-light">
                                <a href="/srv/service/content-v5/sub-folder/81/{$BLOCK.PARENT_ID}/photo-detail/?photo={$G.ID}"
                                    data-width="1000" class="image-wrapper ratio-4x3 popupwin">
                                    <span class="image-inner">
                                        <img src="{$G.IMAGE}" alt="{$G.NAME}">
                                    </span>
                                </a>
                                <div class="col-12 py-1">
                                    <a href="/srv/service/content-v5/sub-folder/81/{$BLOCK.PARENT_ID}/photo-detail/?photo={$G.ID}"
                                        data-width="1000" class="popupwin fw-bold text-body photo-title">{$G.NAME}</a>
                                </div>
                            </div>
                        </div>
                    {foreachelse}
                        <div class="col-12 py-1">
                            {#no_result#}
                        </div>
                    {/foreach}
                </div>
            </div>
            {if $IS_PAGINATION_ACTIVE==1}
                <div class="col-12 bg-light p-1 mb-4 d-flex justify-content-center align-items-center pagination">{$PAGINATION}</div>
            {/if}
        </div>
    </div>
</div> 