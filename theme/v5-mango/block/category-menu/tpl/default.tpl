<div class="col-12 mb-1">
    <div class="w-100 border border-round border-2x">
        {if $SETTING.DISPLAY_TITLE}
            <div class="col-12 fw-bold text-uppercase p-1 d-flex align-items-center" data-toggle="accordion" data-mobile="true">
                {$BLOCK.TITLE}
                <span class="d-block d-md-none ml-auto">
                    <i class="ti-arrow-down"></i>
                    <i class="ti-arrow-up"></i>
                </span>
            </div>
        {/if}
        <nav class="w-100 d-md-block p-1 border-top {if $SETTING.DISPLAY_TITLE}accordion-body{/if}">
            <ul class="clearfix">
                {foreach from=$CATEGORIES item=CAT}
                    <li class="w-100 pb-1">
                        {if $CAT.CHILDREN}
                            <span class="d-flex" data-toggle="accordion">
                                {$CAT.NAME}
                                <span class="ml-auto">
                                    <i class="ti-plus"></i>
                                    <i class="ti-minus"></i>
                                </span>
                            </span>
                            <ul class="col-12 pt-1 pr-0 clearfix accordion-body">
                                {foreach from=$CAT.CHILDREN item=CHILD}
                                    <li class="w-100 pb-1">
                                        {if $CHILD.CHILDREN}
                                            <span class="d-flex" data-toggle="accordion">
                                                {$CHILD.NAME}
                                                <span class="ml-auto">
                                                    <i class="ti-plus"></i>
                                                    <i class="ti-minus"></i>
                                                </span>
                                            </span>
                                            <ul class="col-12 pt-1 pr-0 clearfix accordion-body">
                                                {foreach from=$CHILD.CHILDREN item=CHILD2}
                                                    <li class="w-100 pb-1">
                                                        <a href="{$CHILD2.URL}" class="d-block">{$CHILD2.NAME}</a>
                                                    </li>
                                                {/foreach}
                                            </ul>
                                        {else}
                                            <a href="{$CHILD.URL}" class="d-block">{$CHILD.NAME}</a>
                                        {/if}
                                    </li>
                                {/foreach}
                            </ul>
                        {else}
                            <a href="{$CAT.URL}" class="d-block">{$CAT.NAME}</a>
                        {/if}
                    </li>
                {/foreach}
            </ul>
        </nav>
    </div>
</div>