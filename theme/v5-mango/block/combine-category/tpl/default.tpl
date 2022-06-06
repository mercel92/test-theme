<div class="col-12 blog-categories mb-2">
    <div class="w-100 bg-white border border-2x border-round" data-toggle="affix">
        {if $SETTING.DISPLAY_TITLE}
            <div class="col-12 fw-bold text-uppercase p-1 d-flex align-items-center" data-toggle="accordion" data-mobile="true">
                {$BLOCK.TITLE}
                <span class="d-block d-md-none ml-auto">
                    <i class="ti-arrow-down"></i>
                    <i class="ti-arrow-up"></i>
                </span>
            </div>
        {/if}
        <div class="col-12 d-md-block py-1 {if $SETTING.DISPLAY_TITLE}border-top accordion-body{/if}">
            <ul class="list-style-none">
                {foreach from=$CATEGORIES item=C name=category}
                    <li class="w-100{if !$smarty.foreach.category.last} mb-1{/if}">
                        <a href="/{$C.URL}"
                            class="d-flex fw-bold {if $smarty.server.REQUEST_URI == '/'|cat:$C.URL}text-primary{else}text-body{/if}">
                            <input type="checkbox" class="form-control" data-validate="required" {if $smarty.server.REQUEST_URI == '/'|cat:$C.URL}checked{/if}>
                            <label>
                                <span class="input-checkbox">
                                    <i class="ti-check"></i>
                                </span>
                            </label>
                            {$C.NAME}
                        </a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </div>
</div>