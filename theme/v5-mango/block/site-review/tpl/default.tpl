<div class="col-12">
    {if $SETTING.DISPLAY_TITLE}
    <h1 class="w-100 block-title text-uppercase border-bottom border-light mb-1 mt-1">
        {$BLOCK.TITLE}
    </h1>
    {/if}
    <div class="col-12 bg-light mb-2">
        <div class="row">
            <div class="col-12 col-lg-2 col-md-3 py-1 d-flex align-items-center">
                <select id="comment-sort-{$BLOCK.ID}" class="form-control border-0">
                    <option value="">{#sort#}</option>
                    <option value="date,desc"{if $SORT=='date' && $DIR=='desc' } selected{/if}>{#date_desc#}</option>
                    <option value="date,asc"{if $SORT=='date' && $DIR=='asc' } selected{/if}>{#date_asc#}</option>
                    <option value="rate,desc"{if $SORT=='rate' && $DIR=='desc' } selected{/if}>{#rate_desc#}</option>
                    <option value="rate,asc"{if $SORT=='rate' && $DIR=='asc'} selected{/if}>{#rate_asc#}</option>
                </select>
            </div>
            <div class="col-12 col-md-7 py-1 ml-auto">
                <form class="form-search w-100 position-relative" id="form-search-{$BLOCK.ID}">
                    <input id="search-word-{$BLOCK.ID}" name="q" type="search" placeholder="{#enter_comment#}" value="{$SEARCH_WORD}" class="form-control form-control-md no-cancel" {if $SEARCH_WORD=='' }required{/if}>
                    <button type="submit" id="search-btn-{$BLOCK.ID}" class="btn btn-dark px-1 py-0 text-uppercase">{#search#}</button>
                    <label for="search-word-{$BLOCK.ID}" class="search-icon ti-search text-gray text-center"></label>
                </form>
            </div>
        </div>
    </div>
    {if $TOTAL > 0}
        <div class="w-100 comments-list">
            {foreach from=$COMMENTS item=C}
                <div class="col-12 border border-bottom-0 border-right-0 border-light border-round mb-1">
                    <div class="row">
                        <div class="col-12 col-md-6 p-2 border-bottom border-right border-light">
                            <div class="d-flex">
                                <div class="comment-avatar d-flex align-items-center justify-content-center border-circle">
                                    {if $C.HAS_IMAGE}
                                        <img class="border-circle" src="{$C.COMMENT_IMAGES[0]}" alt="{$C.TITLE}">
                                    {else}
                                        {$C.NAME|mb_substr:0:1}{$C.SURNAME|mb_substr:0:1}
                                    {/if}
                                </div>
                                <div class="comment-info">
                                    {if $C.IS_NAME_DISPLAYED == 1}
                                        <div class="text-content fw-bold mb-1"> {$C.NAME} {$C.SURNAME}</div>
                                    {else}
                                        <div class="text-content fw-bold mb-8">{$C.NAME|mb_substr:0:1}**** {$C.SURNAME|mb_substr:0:1}****</div>
                                    {/if}
                                    <div class="text-content fw-bold mb-8">{$C.TITLE}</div>
                                    <div class="text-content text-gray comment-more">{$C.COMMENT}</div>
                                    <button class="btn p-0 text-content text-underline comment-more-btn d-none" data-show-text="{#show_more#}" data-hide-text="{#hide#}">{#show_more#}</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 col-md-3 p-2 border-bottom border-right border-light">
                            <div class="comment-rate mb-8"><strong>{$C.RATE / 20}</strong>/5</div>
                            <div class="text-content fw-bold mb-8">{#comment_score#}</div>
                            <div class="d-inline-flex position-relative comment-star mb-8">
                                <i class="ti-star text-light"></i>
                                <i class="ti-star text-light"></i>
                                <i class="ti-star text-light"></i>
                                <i class="ti-star text-light"></i>
                                <i class="ti-star text-light"></i>
                                <div class="d-inline-flex position-absolute comment-star-primary" style="width:{$C.RATE}%">
                                    <i class="ti-star text-primary"></i>
                                    <i class="ti-star text-primary"></i>
                                    <i class="ti-star text-primary"></i>
                                    <i class="ti-star text-primary"></i>
                                    <i class="ti-star text-primary"></i>
                                </div>
                            </div>
                            <div class="text-content text-gray">{$C.DATE|date_format:'%d.%m.%Y'} | {$C.DATE|date_format:'%H:%M'}</div>
                        </div>
                        <div class="col-6 col-md-3 py-2 border-bottom border-right border-light vote-buttons">
                            <div class="text-center text-content fw-bold mb-1">{#place_holder#}</div>
                            <div class="row mx-0 mb-1">
                                {if $MEMBER_ID > 0}
                                    <div class="col-6">
                                        <button type="button" id="comment-vote-yes-btn-{$C.ID}{$BLOCK.ID}" class="w-100 btn border-round btn-success text-uppercase vote-click" data-comment-id="{$C.ID}" data-vote="1"{if $C.ALREADY_VOTED !=0} disabled{/if}>{#yes_text#}</button>
                                    </div>
                                    <div class="col-6">
                                        <button type="button" id="comment-vote-no-btn-{$C.ID}{$BLOCK.ID}" class="w-100 btn border-round btn-outline-gray text-uppercase vote-click" data-comment-id="{$C.ID}" data-vote="2"{if $C.ALREADY_VOTED !=0} disabled{/if}>{#no_text#}</button>
                                    </div> 
                                {else}
                                    <div class="col-6">
                                        <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" id="comment-vote-yes-btn-{$C.ID}{$BLOCK.ID}" class="w-100 btn border-round btn-success text-uppercase popupwin">{#yes_text#}</a>
                                    </div>
                                    <div class="col-6">
                                        <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" id="comment-vote-no-btn-{$C.ID}{$BLOCK.ID}" class="w-100 btn border-round btn-outline-gray text-uppercase popupwin">{#no_text#}</a>
                                    </div>
                                {/if}
                            </div>
                            <div class="row mx-0">
                                <div class="col-6">
                                    <div class="yes-btn d-block w-100 text-center text-uppercase fw-bold text-body ease">
                                        <i class="ti-thumbs-up d-block"></i>
                                        {#yes_text#}: {$C.YES_VOTE}
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="no-btn d-block w-100 text-center text-uppercase fw-bold text-body ease">
                                        <i class="ti-thumbs-down d-block"></i>
                                        {#no_text#}: {$C.NO_VOTE}
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
    {if $MEMBER_ID > 0}
        <form id="comment-form-{$BLOCK.ID}" action="/srv/service/guest/comment" method="POST" novalidate autocomplete="off" class="w-100">
            <div class="row">
                <div class="col-12 col-md-6">
                    <div class="w-100 popover-wrapper position-relative mb-1">
                        <select name="rate" id="rate-{$BLOCK.ID}" class="form-control form-control-md" data-validate="required">
                            <option value="1">{#vote_worst#}</option>
                            <option value="2">{#vote_soso#}</option>
                            <option value="3" selected>{#vote_good#}</option>
                            <option value="4">{#vote_great#}</option>
                            <option value="5">{#vote_best#}</option>
                        </select>
                    </div>
                    <div class="w-100 popover-wrapper position-relative mb-1">
                        <input type="text" name="title" placeholder="{#comment_title#}" id="title-{$BLOCK.ID}" class="form-control form-control-md" data-toggle="placeholder" data-validate="required">
                    </div>
                    <div class="w-100 popover-wrapper position-relative mb-1">
                        <label class="d-flex">{#name_in_comment#}</label>
                        <div class="d-inline-block mr-1">
                            <input type="radio" id="displayNameNo-{$BLOCK.ID}" name="displayName" value="0" class="form-control" checked>
                            <label for="displayNameNo-{$BLOCK.ID}"><span class="input-radio"><i class="ti-check"></i></span> {#no_text#}</label>
                        </div>
                        <div class="d-inline-block">
                            <input type="radio" id="displayNameYes-{$BLOCK.ID}" name="displayName" value="1" class="form-control">
                            <label for="displayNameYes-{$BLOCK.ID}"><span class="input-radio"><i class="ti-check"></i></span> {#yes_text#}</label>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="w-100 popover-wrapper position-relative mb-1">
                        <textarea name="text" placeholder="{#comment#}" id="text-{$BLOCK.ID}" class="form-control form-control-md" data-toggle="placeholder" data-validate="required"></textarea>
                    </div>
                    <div class="w-100">
                        <button type="submit" id="send-{$BLOCK.ID}" class="w-100 btn btn-primary text-uppercase">{#send#}</button>
                    </div>
                </div>
            </div>
        </form>
    {else}
        <div class="w-100 bg-light p-1 text-bold text-black mb-2">
            {#no_member_comment#} <a href="/srv/service/content-v5/sub-folder/5/1006/popup-login" class="text-primary text-underline fw-bold popupwin">{#login#}</a> {#please_do#}
        </div>
    {/if}
    {if $IS_PAGINATION_ACTIVE}
        <div class="col-12 bg-light p-1 mb-4 d-flex justify-content-center align-items-center pagination">{$PAGINATION}</div>
    {/if}
</div>