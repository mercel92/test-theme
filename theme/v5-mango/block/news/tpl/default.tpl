<div class="col-12">
    <div class="row">
        {foreach from=$NEWS_LIST item=N}
        <div class="col-12 col-sm-6 mb-2">
            <div class="w-100 h-100 bg-light">
                <div class="col-12 px-0 py-1">
                    <div class="col-12 mb-1"><a href="/{$N.URL}" class="fw-bold text-body d-inline-block news-title">{$N.TITLE}</a></div>
                    <div class="col-12 mb-1 news-description">{$N.TEXT|strip_tags}</div>
                    <div class="col-12 d-flex align-items-center justify-content-between">
                        <a href="/{$N.URL}" class="btn btn-gray btn-sm text-uppercase">{#continue#}</a>
                        <div class="d-flex fw-bold text-body"><i class="ti-calendar mr-5"></i> {$N.DATE}</div>
                    </div>
                </div>
            </div>
        </div>
        {/foreach}
    </div>
</div>
{if $IS_PAGINATION_ACTIVE==1}
    <div class="col-12">
        <div class="col-12 bg-light p-1 mb-4 d-flex justify-content-center align-items-center pagination">{$PAGINATION}</div>
    </div>
{/if}