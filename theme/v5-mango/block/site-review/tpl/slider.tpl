<div class="col-12">
    <div class="row mb-1">
        {if $SETTING.DISPLAY_TITLE}
            <div class="col-12 block-title d-flex align-items-center justify-content-center no-line mb-1">
                {$BLOCK.TITLE}
                <a href="/{url type='page' id='66'}" class="text-link small-text ml-1">Tüm Yorumları Gör</a>
            </div>
        {/if}
        {if $TOTAL > 0}
            <div class="col-12 position-relative slider-block-wrapper">
                <div id="comment-slider-{$BLOCK.ID}" class="swiper-container">
                    <div class="swiper-wrapper">
                        {foreach from=$COMMENTS item=C}
                            <div class="swiper-slide">
                                <div class="col-12">
                                    <div class="text-primary mb-1 text-center">{$C.TITLE}</div>
                                    <div class="text-gray text-center">{$C.COMMENT}</div>
                                </div>
                                {if $C.IS_NAME_DISPLAYED == 1}
                                    <div class="fw-bold text-center mt-1"> {$C.NAME} {$C.SURNAME}</div>
                                {else}
                                    <div class="fw-bold text-center mt-1">{$C.NAME|mb_substr:0:1}**** {$C.SURNAME|mb_substr:0:1}****</div>
                                {/if}
                            </div>
                        {/foreach}
                    </div>
                    <div id="swiper-pagination-{$BLOCK.ID}" class="swiper-pagination bottom"></div>
                </div>
            </div>
        {/if}
    </div>
</div>