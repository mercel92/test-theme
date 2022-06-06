<div class="col-12">
    <h1 class="w-100 block-title text-uppercase border-bottom border-light mb-1 mt-1">
        {$BLOCK.TITLE}
    </h1>
    <div class="col-12 bg-light mb-2">
        <div class="row">
            <div class="col-12 col-lg-2 col-md-3 py-1 d-flex align-items-center">
                <select id="comment-sort-{$BLOCK.ID}" class="form-control border-0">
                    <option value="">{#sort#}</option>
                    <option value="date,desc" {if $SORT=='date' && $DIR=='desc'}selected{/if}>{#date_desc#}</option>
                    <option value="date,asc" {if $SORT=='date' && $DIR=='asc'}selected{/if}>{#date_asc#}</option>
                    <option value="rate,desc" {if $SORT=='rate' && $DIR=='desc'}selected{/if}>{#rate_desc#}</option>
                    <option value="rate,asc" {if $SORT=='rate' && $DIR=='asc'}selected{/if}>{#rate_asc#}</option>
                </select>
            </div>
            <div class="col-12 col-md-7 py-1 ml-auto">
                <form class="form-search w-100 position-relative" id="form-search-{$BLOCK.ID}">
                    <input id="search-word-{$BLOCK.ID}" name="q" type="search" placeholder="{#enter_comment#}" value="{$SEARCH_WORD}" class="form-control form-control-md no-cancel" {if $SEARCH_WORD == ''}required{/if}>
                    <button type="submit" class="btn btn-dark px-1 py-0">{#search#}</button>
                    <label for="search-word-{$BLOCK.ID}" class="search-icon ti-search text-gray text-center"></label>
                </form>
            </div>
        </div>
    </div>

    {if $TOTAL > 0}
    <div class="w-100 comments-list">
        {foreach from=$COMMENTS item=C}
            <div class="col-12 border border-light border-round mb-1">
                <div class="row">
                    <div class="col-12 col-md-5 p-1 border-md-0 border-right border-light">
                        <div class="row align-items-center h-100">
                            <div class="col-3">
                                <a href="/{$C.PRODUCT_URL}" class="image-wrapper">
                                    <span class="image-inner">
                                        <img src="{$C.PRODUCT_IMAGE}" alt="{$C.PRODUCT_NAME} - {$C.BRAND}">
                                    </span>
                                </a>
                            </div>
                            <div class="col-9">
                                <div class="text-content fw-bold mb-1 comment-brand">{$C.BRAND}</div>
                                <a href="/{$C.PRODUCT_URL}"
                                    class="d-flex text-content text-gray mb-2 comment-name">{$C.PRODUCT_NAME}</a>
                                {if $C.IS_PRODUCT_PURCHASED==1}
                                <div class="d-flex">
                                    <div class="d-inline-flex align-items-center bg-primary text-content text-white border-round px-1">
                                        {#product_purchased#} <i class="ti-basket comment-cart"></i>
                                    </div>
                                </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-7 p-1">
                        <div class="text-content fw-bold mb-1 comment-title">{$C.TITLE}</div>
                        <div class="text-content text-gray mb-2 comment-fullbody">{$C.COMMENT}</div>
                        <div class="row">
                            <div class="col-12 col-md-8 mb-1">
                                <div class="d-flex flex-wrap text-content text-gray">
                                    <div class="border-right border-light mr-1 pr-1 comment-member">
                                        {if $C.MEMBER_NAME != ''}
                                            {if $C.DISPLAY_NAME=='1'}
                                                {$C.MEMBER_NAME} {$C.MEMBER_SURNAME}
                                            {else}
                                                {$C.MEMBER_NAME|mb_substr:0:1}**** {$C.MEMBER_SURNAME|mb_substr:0:1}****
                                            {/if}
                                        {else}
                                            {#no_name#}
                                        {/if}
                                    </div>
                                    <div class="comment-date">{$C.DATE|date_format:'%d.%m.%Y'} |
                                        {$C.DATE|date_format:'%H:%M'}</div>
                                </div>
                            </div>
                            <div class="col-12 col-md-4">
                                <div class="w-100 text-content d-flex flex-wrap align-items-center justify-content-flex-start md-justify-content-flex-end">
                                    <div class="fw-bold mr-1">{#comment#}</div>
                                    <div class="d-flex mr-1"><span class="fw-bold">{$C.RATING}</span>/5</div>
                                    <div class="d-flex position-relative comment-star">
                                        {for $foo=1 to 5}
                                            <i class="ti-star text-light"></i>
                                        {/for}
                                        <div class="d-flex position-absolute comment-star-primary"
                                            style="width:{$C.RATING * 20}%">
                                            {for $foo=1 to 5}
                                                <i class="ti-star text-primary"></i>
                                            {/for}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
    {else}
        <div class="w-100 bg-light p-1 text-bold text-black mb-2">
            {#no_result#}
        </div>
    {/if}
    {if $IS_PAGINATION_ACTIVE}
        <div class="col-12 bg-light p-1 mb-4 d-flex justify-content-center align-items-center pagination">{$PAGINATION}</div>
    {/if}
</div>