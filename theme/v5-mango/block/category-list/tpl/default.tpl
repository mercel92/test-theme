<div class="col-12 col-md-2">
    <div class="w-100 position-desktop-sticky letter-stikcy">
        <div class="d-flex d-md-none fw-bold text-black">{#list#}</div>
        <div class="row row-5 letter-item-titles">
            {foreach from=$LETTERS item=L}
                <div class="col-auto col-md-4 col-lg-3 p-1">
                    <a href="?letter={$L}" class="d-block text-center bg-light border-round{if $smarty.get.letter == $L} active{/if}">{$L}</a>
                </div>
            {/foreach}
            <div class="col-auto col-md-4 col-lg-3 p-1">
                <a href="?letter=0" class="d-block text-center bg-light border-round {if $smarty.get.letter == '0'} active{/if}">1-9</a>
            </div>
        </div>
    </div>
</div>
<div class="col-12 col-md-10">
    <div class="row mb-1">
        <div class="col-12">
            <h1 class="block-title no-line mb-1">{#category_search#}</h1>
            <form class="form-search w-100 position-relative mb-2" id="form-search-{$BLOCK.ID}">
                <input id="search-word-{$BLOCK.ID}" name="q" type="search" placeholder="{#enter_category#}" value="{$SEARCH_WORD}" class="form-control form-control-md no-cancel" {if $SEARCH_WORD == ''}required{/if}>
                <button type="submit" class="btn btn-dark px-1 py-0">{#search#}</button>
                <label for="search-word-{$BLOCK.ID}" class="search-icon ti-search text-gray text-center"></label>
            </form>
        </div>
        {if $DATA_LIST|@count > 0}
            {if $SEARCH_WORD || $smarty.get.letter}
                <div class="col-12 mb-1">
                    <strong class="text-primary">{$DATA_LIST|@count}</strong> {#result#}
                </div>
            {/if}
        {/if}
        {foreach from=$DATA_LIST item=D}
            <div class="col-6 col-md-4 mb-2">
                <div class="row">
                    <div class="col-12 data-list-item mb-1">
                        <a href="/{$D.URL}" class="block-title">
                            {$D.NAME}
                        </a>
                    </div>
                    {if $D.CHILDREN|@count > 0}
                        <div class="col-12 category-items">
                            {foreach from=$D.CHILDREN item=CHILD name="ch"}
                                <a href="/{$CHILD.URL}" class="text-content">
                                    {$CHILD.NAME}{if !$smarty.foreach.ch.last},{/if}
                                </a>
                            {/foreach}
                        </div>
                    {/if}
                </div>
            </div>
        {foreachelse}
            <div class="col-12 mb-1">{#no_result#}</div>
        {/foreach}
        {if $DISPLAY_PAGINATION}
            <div class="col-12">
                <div class="col-12 bg-light p-1 mb-4 d-flex justify-content-center align-items-center pagination">{$PAGINATION}</div>
            </div>
        {/if}
    </div>
</div>