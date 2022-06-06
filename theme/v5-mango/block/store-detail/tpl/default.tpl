<div class="col-12 mb-2">
    <div class="col-12 p-1 border border-light border-round mb-1">
        <div class="row align-items-center border-bottom mb-2">
            {if $STORE.PHOTO_LIST|@count > 0}
                <div class="col-12 col-sm-4">
                    <div class="w-100 position-relative slider-block-wrapper mb-1">
                        <div id="swiper-{$BLOCK.ID}" class="swiper-container">
                            <div class="swiper-wrapper" id="gallery-{$BLOCK.ID}">
                                {foreach from=$STORE.PHOTO_LIST item=PHOTO name=image}
                                    {if $PHOTO != ''}
                                        <a class="w-100 swiper-slide" href="{$SITE}Data/Magazalar/{$PHOTO}">
                                            <div class="image-wrapper ratio-4x3">
                                                <span class="image-inner">
                                                    <img src="{$SITE}Data/Magazalar/{$PHOTO}" alt="{$STORE.NAME} - {$smarty.foreach.image.iteration}">
                                                </span>
                                            </div>
                                        </a>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                        {if $STORE.PHOTO_LIST|@count > 1}
                        <div id="swiper-prev-{$BLOCK.ID}" class="swiper-button-prev"><i class="ti-arrow-left"></i></div>
                        <div id="swiper-next-{$BLOCK.ID}" class="swiper-button-next"><i class="ti-arrow-right"></i></div>
                        {/if}
                    </div>
                </div>
            {/if}
            <div class="col-12 col-sm-8 order-sm-2 py-1">
                <div class="row">
                    <h1 class="col-12 mb-1 fw-bold fs-18"><i class="ti-location text-primary mr-5"></i>{$STORE.NAME}</h1>
                    {if $STORE.ADDRESS}
                        <div class="col-12 col-md-7 mb-1">
                            <div class="text-primary fw-bold">{#address#}</div>
                            <div>{$STORE.ADDRESS}</div>
                        </div>
                    {/if}
                    {if $STORE.PHONE}
                        <div class="col-12 col-md-5 mb-1">
                            <div class="text-primary fw-bold">{#phone#}</div>
                            <div><a href="tel:{$STORE.PHONE|replace:' ':''}" class="text-body">{$STORE.PHONE}</a></div>
                        </div>
                    {/if}
                    {if $STORE.FAX}
                        <div class="col-12 col-md-7 mb-1">
                            <div class="text-primary fw-bold">{#fax#}</div>
                            <div>{$STORE.FAX}</div>
                        </div>
                    {/if}
                    {if $STORE.EMAIL}
                        <div class="col-12 col-md-5 mb-1">
                            <div class="text-primary fw-bold">{#email#}</div>
                            <div><a href="mailto:{$STORE.EMAIL}" class="text-body">{$STORE.EMAIL}</a></div>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
        <div class="row">
            {if $STORE.COUNTRY}
                <div class="col-6 col-md-auto mb-1">
                    <div><strong class="text-primary">{#country#} : </strong> {$STORE.COUNTRY}</div>
                </div>
            {/if}
            {if $STORE.CITY}
                <div class="col-6 col-md-auto mb-1">
                    <div><strong class="text-primary">{#city#} : </strong> {$STORE.CITY}</div>
                </div>
            {/if}
            {if $STORE.TOWN}
                <div class="col-6 col-md-auto mb-1">
                    <div><strong class="text-primary">{#town#} : </strong> {$STORE.TOWN}</div>
                </div>
            {/if}
            {if $STORE.DISTRICT}
                <div class="col-6 col-md-auto mb-1">
                    <div><strong class="text-primary">{#district#} : </strong> {$STORE.DISTRICT}</div>
                </div>
            {/if}
            {if $STORE.ADDITIONAL_FIELD1}
                <div class="col-12 mb-1">
                    {$STORE.ADDITIONAL_FIELD1}
                </div>
            {/if}
            {if $STORE.ADDITIONAL_FIELD2}
                <div class="col-12 mb-1">
                    {$STORE.ADDITIONAL_FIELD2}
                </div>
            {/if}
            {if $STORE.ADDITIONAL_FIELD3}
                <div class="col-12 mb-1">
                    {$STORE.ADDITIONAL_FIELD3}
                </div>
            {/if}
        </div>
    </div>

    {if $STORE.COORDINATE_Y == "0" || $STORE.COORDINATE_Y == "" || $STORE.COORDINATE_X == "0" || $STORE.COORDINATE_X == "" }

        {if $STORE.IFRAMEEMBED}
            <div class="w-100 store-map-canvas">{$STORE.IFRAMEEMBED}</div>
        {/if}

    {else}
        <input type="hidden" id="gMapKey-{$BLOCK.ID}" value="AIzaSyBtWJ53NfwS05NLb3IK1z5SMaU0uUJS2Zk">
        <div class="w-100 store-map-canvas" id="store-map-canvas-{$BLOCK.ID}"></div>
        <input type="hidden" id="gMapY-{$BLOCK.ID}" value="{$STORE.COORDINATE_Y}">
        <input type="hidden" id="gMapX-{$BLOCK.ID}" value="{$STORE.COORDINATE_X}">
        <textarea id="gMapContent-{$BLOCK.ID}" class="d-none">
            <div class="map-info">
                <div class="fw-bold block-title no-line mb-1 map-name">{$STORE.NAME}</div>
                <div class="mb-1 map-adress">{$STORE.ADDRESS}</div>
                <a target="_blank" href="//www.google.com/maps/dir//{$STORE.COORDINATE_X},{$STORE.COORDINATE_Y}/@{$STORE.COORDINATE_X},{$STORE.COORDINATE_Y},18z" class=" btn btn-outline-primary fw-bold text-content text-uppercase mr-1
            map-link">{#address_description#}</a>
            </div>
        </textarea>
    {/if}
</div>