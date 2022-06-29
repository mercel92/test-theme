<div class="row">
    {foreach from=$SUB_LIST item=SUB name=variant}
        <div class="col-auto mb-1">
            <a href="javascript:void(0);"
            id="{$SUB.TYPE_ID}"
            data-id="{$SUB.TYPE_ID}"
            data-subproduct-id="{$SUB.ID}"
            data-pid="{$P.ID}"
            data-target="{$P.ID}{$BLOCK.ID}"
            data-type="{$SUB.TYPE}"
            data-code="{$SUB.CODE}"
            data-price="{$SUB.PRICE}"
            data-stock="{$SUB.STOCK}"
            data-barcode="{$SUB.BARCODE}"
            data-mop="{$SUB.MONEY_ORDER_PERCENT}"
            data-vat="{$SUB.VAT}"
            data-not-discounted="{$SUB.PRICE_NOT_DISCOUNTED}"
            data-group-id="{$GRUP_TIP_NO}"
            data-toggle="variant"
                class="d-block border sub-image-item{if $SUB.TYPE_ID == $SELECTED && $IS_DEFAULT_VARIANT_ACTIVE|default:1 == 1} selected{/if}{if $SUB.IN_STOCK == false && $NEGATIVE_STOCK == 0} passive{/if}">
                <figure class="image-wrapper">
                    <span class="image-inner">
                        <img src="{$SUB.IMAGE.SMALL}" alt="{$P.TITLE} {$SUB.TYPE}">
                    </span>
                </figure>
            </a>
        </div>
    {/foreach}
</div>