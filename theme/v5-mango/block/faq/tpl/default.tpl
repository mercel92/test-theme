<div class="col-12">
    <div class="col-12 p-2 py-1 border border-round mb-2">
        <div class="row">
            <div class="col-12 col-md-7 offset-md-1 py-1 order-md-2">
                {if $SETTING.DISPLAY_TITLE}
                    <div class="w-100 mb-2 block-title">{$BLOCK.TITLE}</div>
                {/if}
                {if $SETTING.INFO}
                    <div class="mb-2">{$SETTING.INFO}</div>
                {/if}
                <form class="form-search w-100 position-relative mb-2" id="form-search-{$BLOCK.ID}">
                    <input id="search-word-{$BLOCK.ID}" name="q" type="search" placeholder="{#search_placeholder#}" value="{$SEARCH_WORD}" class="form-control form-control-md no-cancel" {if $SEARCH_WORD == ''}required{/if}>
                    <button type="submit" id="search-btn-{$BLOCK.ID}" class="btn btn-dark px-1 py-0 text-uppercase">{#search#}</button>
                    <label for="search-word-{$BLOCK.ID}" class="search-icon ti-search text-gray text-center"></label>
                </form>
            </div>
            <div class="col-12 col-md-3 py-1 order-md-1">
                <div class="text-center mb-1">
                    <i class="ti-question-circle-o faq-icon"></i>
                </div>
                <div class="fw-semibold text-center mb-1">
                    {#cant_find_answer#}<br>{#new_question#}
                </div>
                <a href="/{url type='page' id='83'}" id="ask-question-{$BLOCK.ID}" class="w-100 btn btn-primary fw-bold text-uppercase">{#ask_question#}</a>
            </div>
        </div>
    </div>
    <div class="col-12 faq-content">
        <div class="row">
            {if $TOTAL > 0}
                {foreach from=$MESSAGE_LIST item=M}
                    <div class="col-12 p-0 border border-light border-round mb-2 faq-item">
                        <div class="col-12 py-1 px-2 border-bottom border-light text-primary fw-bold">{$M.FULLNAME}</div>
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
            <div class="col-12 col-md-auto text-center total-info py-1">{#no_record#}</div>
        {else}
            <div class="col-12 col-md-auto text-center total-info py-1">{#total_result#} {$TOTAL}</div>
            <div class="col-12 col-md-auto ml-auto d-flex justify-content-center align-items-center py-1">
                <div class="pagination">{$PAGINATION}</div>
            </div>
        {/if}
    </div>
</div>