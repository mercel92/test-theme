<div class="col-12 mb-1">
    <div class="w-100 bg-white border border-round">
        {foreach from=$SETTING.CONTENT_LIST item=CONTENT name=content}
            <div class="w-100{if !$smarty.foreach.content.last} border-bottom{/if} text-body customer-service-item">
                <div class="title px-2 py-1 d-flex align-items-center justify-content-between" data-toggle="accordion">
                    <span>{$smarty.foreach.content.iteration}- {$CONTENT.NAME}</span>
                    <span class="icon-wrapper">
                        <i class="ti-plus"></i>
                        <i class="ti-minus"></i>
                    </span>
                </div>
                <div class="py-1 px-2 description accordion-body border-top">{$CONTENT.DESCRIPTION}</div>
            </div>
        {foreachelse}
            <div class="col-12 p-1">
                {#no_result#}
            </div>
        {/foreach}
    </div>
</div>