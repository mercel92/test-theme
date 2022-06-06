<div class="col-12">
    <div class="col-12 p-2 py-1 border border-round mb-2">
        <div class="row">
            <div class="col-12 col-md-7 offset-md-1 py-1 order-md-2">
                {if $SETTING.DISPLAY_TITLE}
                    <div class="w-100 mb-2 block-title">
                        {$BLOCK.TITLE}
                    </div>
                {/if}
                {if $SETTING.INFO}
                    <div class="mb-2">
                        {$SETTING.INFO}
                    </div>
                {/if}
                <form class="form-search w-100 position-relative" id="form-search-{$BLOCK.ID}">
                    <input id="search-word-{$BLOCK.ID}" name="q" type="search" placeholder="{#enter_question#}" value="{$SEARCH_WORD}" class="form-control form-control-md no-cancel" {if $SEARCH_WORD == ''}required{/if}>
                    <button type="submit" id="search-btn-{$BLOCK.ID}" class="btn btn-dark px-1 py-0 text-uppercase">{#search#}</button>
                    <label for="search-word-{$BLOCK.ID}" class="search-icon ti-search text-gray text-center"></label>
                </form>
            </div>
            <div class="col-12 col-md-3 py-1 order-md-1">
                <div class="text-center mb-1">
                    <i class="ti-lifebuoy customer-icon"></i>
                </div>
                <div class="fw-semibold text-center mb-1">
                    {#cant_find_answer#}<br>{#new_question#}.
                </div>
                <a href="/{url type='page' id='83'}" id="ask-question-{$BLOCK.ID}" class="w-100 btn btn-primary fw-bold text-uppercase">{#ask_question#}</a>
            </div>
        </div>
    </div>
</div>