<div class="col-12">
    <div class="col-12 p-2 py-1 border border-round mb-2">
        <div class="row">
            <div class="col-12 col-md-7 offset-md-1 py-1 order-md-2">
                <div class="w-100 mb-2 block-title">
                    {#block_title#}
                </div>
                <div class="mb-2">
                    {$SETTING.INFO}
                </div>
                <form class="form-search w-100 position-relative mb-2" id="form-search-{$BLOCK.ID}">
                    <input id="search-word-{$BLOCK.ID}" name="q" type="search" placeholder="{#search_book#}" value="{$SEARCH_WORD}" class="form-control form-control-md no-cancel" {if $SEARCH_WORD == ''}required{/if}>
                    <button type="submit" id="search-btn-{$BLOCK.ID}" class="btn btn-dark px-1 py-0">{#search#}</button>
                    <label for="search-word-{$BLOCK.ID}" class="search-icon ti-search text-gray text-center"></label>
                </form>
            </div>
            <div class="col-12 col-md-3 py-1 order-md-1">
                <div class="text-center mb-1">
                    <i class="ti-question-circle-o guest-book-icon"></i>
                </div>
                <div class="fw-semibold text-center mb-1">
                    {#cant_find_answer#}<br>{#new_question#}
                </div>
                <a href="/srv/service/content-v5/sub-folder/{$PAGE_ID}/{$BLOCK.PARENT_ID}/new-message" id="new-message-{$BLOCK.ID}" class="w-100 btn btn-primary fw-bold text-uppercase popupwin" data-width="580">{#write#}</a>
            </div>
        </div>
    </div>
    <div class="col-12 guest-book-content">
        <div class="row">
            {if $TOTAL > 0}
            {foreach from=$MESSAGE_LIST item=M}
            <div class="col-12 p-0 border border-light border-round mb-2 guest-book-item">
                <div class="col-12 py-1 px-2 border-bottom border-light text-primary fw-bold">
                    {$M.FULLNAME}
                </div>
                <div class="col-12 py-1 px-2{if $M.ANSWER!=''} border-bottom border-light{/if} bg-light">
                    <div class="p-1 mb-1 d-inline-block bg-primary text-white border-round fw-bold text-uppercase">{#question#}</div>
                    <div>{$M.CONTENT}</div>
                </div>
                {if $M.ANSWER != ''}
                <div class="col-12 py-1 px-2">
                    <div class="p-1 mb-1 d-inline-block bg-success text-white border-round fw-bold text-uppercase">{#answer#}</div>
                    <div>{$M.ANSWER}</div>
                </div>
                {/if}
            </div>
            {/foreach}
            {/if}
        </div>
    </div>
</div>

<div class="col-12">
    <div class="d-flex flex-wrap justify-content-between align-items-center bg-light mb-4">
        {if $TOTAL == 0}
            <div class="col-12 col-md-auto text-center total-info py-1">{#no_result#}</div>
        {else}
            <div class="col-12 col-md-auto text-center total-info py-1">
                <span class="text-primary text-lowercase">{$TOTAL} {#question#}</span> {#total_result#}
            </div>
            <div class="col-12 col-md-auto ml-auto d-flex justify-content-center align-items-center py-1">
                <div class="pagination">{$PAGINATION}</div>
            </div>
        {/if}
    </div>
</div>