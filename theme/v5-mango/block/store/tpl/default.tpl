<div class="col-12 mb-3">
    {if $SETTING.DISPLAY_TITLE}
        <h1 class="block-title mb-2">
            {$BLOCK.TITLE}
        </h1>
    {/if}
    <div class="row mb-1">
        {if $SETTING.DISPLAY_COUNTRY}
            <div class="col-12 col-sm-12 col-md-4 col-lg-2 mb-1">
                <div class="w-100 popover-wrapper position-relative">
                    <select id="store-country-list-{$BLOCK.ID}" class="form-control form-control-md store-select-{$BLOCK.ID}" name="country">
                        <option value="">{#country#}</option>
                        {foreach from=$COUNTRY_LIST item=C}
                            <option value="{$C.CODE}"
                                {if $smarty.get.country == $C.CODE}selected{/if}>{$C.NAME}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
        {/if}
        {if $SETTING.DISPLAY_CITY}
            <div class="col-6 col-sm-6 col-md-4 col-lg-2 mb-1">
                <div class="w-100 popover-wrapper position-relative">
                    <select id="store-city-list-{$BLOCK.ID}" class="form-control form-control-md store-select-{$BLOCK.ID}" name="city">
                        <option value="">{#city#}</option>
                        {if $smarty.get.country}
                            {foreach from=$CITY_LIST item=C}
                                <option data-parent="{$C.PARENT}" value="{$C.CODE}"
                                    {if $smarty.get.city == $C.CODE}selected{/if}>{$C.NAME}</option>
                            {/foreach}
                        {else if !$SETTING.DISPLAY_COUNTRY}
                            {foreach from=$CITY_LIST item=C}
                                <option data-parent="{$C.PARENT}" value="{$C.CODE}"
                                    {if $smarty.get.city == $C.CODE}selected{/if}>{$C.NAME}</option>
                            {/foreach}
                        {/if}
                    </select>
                </div>
            </div>
        {/if}
        {if $SETTING.DISPLAY_TOWN}
            <div class="col-6 col-sm-6 col-md-4 col-lg-2 mb-1">
                <div class="w-100 popover-wrapper position-relative">
                    <select id="store-town-list-{$BLOCK.ID}" class="form-control form-control-md store-select-{$BLOCK.ID}" name="town">
                        <option value="">{#town#}</option>
                        {if $smarty.get.country && $smarty.get.city}
                            {foreach from=$TOWN_LIST item=T}
                                <option data-parent="{$T.PARENT}" value="{$T.CODE}"
                                    {if $smarty.get.town == $T.CODE}selected{/if}>{$T.NAME}</option>
                            {/foreach}
                        {else if !$SETTING.DISPLAY_CITY}
                            {foreach from=$TOWN_LIST item=T}
                                <option data-parent="{$T.PARENT}" value="{$T.CODE}"
                                    {if $smarty.get.town == $T.CODE}selected{/if}>{$T.NAME}</option>
                            {/foreach}
                        {/if}
                    </select>
                </div>
            </div>
        {/if}
        <div class="col-12 col-sm-12 col-md-12 col-lg-6 mb-1">
            <form class="form-search w-100 position-relative" id="form-search-{$BLOCK.ID}">
                <div class="w-100 popover-wrapper position-relative">
                    <input id="search-word-{$BLOCK.ID}" type="search" name="q" placeholder="{#store_name#}" value="{$SEARCH_WORD}" class="form-control form-control-md no-cancel" {if $SEARCH_WORD == ''}required{/if} />
                </div>
                <button type="submit" id="search-btn-{$BLOCK.ID}" class="btn btn-dark px-1 py-0">{#search#}</button>
                <label for="search-word-{$BLOCK.ID}" class="search-icon ti-search text-gray text-center"></label>
            </form>
        </div>
    </div>
    {if $SETTING.GOOGLE_MAPS_API_KEY}
    <div class="w-100 position-relative">
        <div id="maps-location-pos" class="p-1">
            <div class="mb-1 fw-medium text-content text-center">{#share_location#}</div>
            <div class="d-flex align-items-center justify-content-center">
                <button id="nearest-location-button" class="btn btn-primary fw-bold text-content"><i class="ti-location mr-1"></i>{#location#}</button>
            </div>
        </div>
        <div class="w-100 mb-2 store-map-canvas" id="store-map-canvas-{$BLOCK.ID}"></div>
    </div>
    {/if}
    <div class="row">
        {if $STORE_LIST|@count > 0}
        <div class="col-12 mb-1 fw-medium fs-18">{#results_total#} <span class="text-primary fw-bold">{$STORE_LIST|@count} {#store#}</span> {#listed#}</div>
        {else}
        <div class="col-12 mb-1 fw-medium fs-18">{#no_result#}</div>
        {/if}
        <div class="col-12 store-list">
            {foreach from=$STORE_LIST item=S}
                <div class="w-100 border border-light border-round mb-1">
                    <div class="col-12 p-1 store-title fw-bold fs-18 d-flex align-items-center" data-toggle="accordion">
                        {$S.NAME}
                        <span class="ml-auto">
                            <i class="ti-plus"></i>
                            <i class="ti-minus"></i>
                        </span>
                    </div>
                    <div class="col-12 p-1 store-content">
                        <div class="row">
                            <div class="col-12 col-sm-8 mb-1">
                                {if $S.ADDRESS || $S.PHONE}
                                    <div class="row mb-2">
                                        {if $S.ADDRESS}
                                            <div class="col-12 col-sm-6 col-md-4">
                                                <div class="fw-bold">{#address#} :</div>
                                                <div>{$S.ADDRESS}</div>
                                            </div>
                                        {/if}
                                        {if $S.PHONE}
                                            <div class="col-12 col-sm-6 col-md-4">
                                                <div class="fw-bold">{#phone#}</div>
                                                <div>{$S.PHONE}</div>
                                            </div>
                                        {/if}
                                    </div>
                                {/if}
                                {if $S.FAX || $S.EMAIL}
                                    <div class="row mb-2">
                                        {if $S.FAX}
                                            <div class="col-12 col-sm-6 col-md-4">
                                                <div class="fw-bold">{#fax#}</div>
                                                <div>{$S.FAX}</div>
                                            </div>
                                        {/if}
                                        {if $S.EMAIL}
                                            <div class="col-12 col-sm-6 col-md-4">
                                                <div class="fw-bold">{#email#}</div>
                                                <div>{$S.EMAIL}</div>
                                            </div>
                                        {/if}
                                    </div>
                                {/if}

								{if $S.COORDINATE_Y == "0" || $S.COORDINATE_Y == "" || $S.COORDINATE_X == "0" || $S.COORDINATE_X == "" }
                                {else}
                                    <a target="_blank" href="//www.google.com/maps/dir//{$S.COORDINATE_X},{$S.COORDINATE_Y}/@{$S.COORDINATE_X},{$S.COORDINATE_Y},18z" class="btn btn-outline-primary fw-bold text-content text-uppercase px-3 py-1 mr-1">
                                        <i class="ti-location"></i> {#address_description#}
                                    </a>
                                {/if}
                                <a href="/{$S.SEO_LINK}" class="btn btn-primary fw-bold text-content text-uppercase px-3 py-1">{#detail#}</a>
                            </div>
                            <div class="col-12 col-sm-4 mb-1">
                                {if $S.COORDINATE_Y == "0" || $S.COORDINATE_Y == "" || $S.COORDINATE_X == "0" || $S.COORDINATE_X == "" }
                                    {if $S.IFRAMEEMBED}
                                        <div class="w-100 map-canvas-iframe">{$S.IFRAMEEMBED}</div>
                                    {/if}
                                {else}
                                    <div class="w-100 map-canvas h-100" data-id="{$S.ID}{$BLOCK.ID}" data-name="{$S.NAME}" id="store-map-canvas-{$S.ID}{$BLOCK.ID}"></div>
                                    <input type="hidden" id="gMapY-{$S.ID}{$BLOCK.ID}" value="{$S.COORDINATE_Y}">
                                    <input type="hidden" id="gMapX-{$S.ID}{$BLOCK.ID}" value="{$S.COORDINATE_X}">
                                    <textarea id="gMapContent-{$S.ID}{$BLOCK.ID}" class="d-none">
                                        <div class="map-info">
                                            <div class="fw-bold block-title no-line mb-1 map-name">{$S.NAME}</div>
                                            <div class="mb-1 map-adress">{$S.ADDRESS}</div>
                                            <a target="_blank" href="//www.google.com/maps/dir//{$S.COORDINATE_X},{$S.COORDINATE_Y}/@{$S.COORDINATE_X},{$S.COORDINATE_Y},18z" class=" btn btn-outline-primary fw-bold text-content text-uppercase mr-1
                                                map-link">{#address_description#}</a>
                                            <a href="/{$S.SEO_LINK}" class="btn btn-primary fw-bold text-content text-uppercase map-link">{#detail#}</a>
                                        </div>
                                    </textarea>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>