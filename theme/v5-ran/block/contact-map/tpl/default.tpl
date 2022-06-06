{if $SETTING.GOOGLE_MAPS_API_KEY}
<div class="col-12 mb-2">
    <div class="w-100">
        {if $SETTING.DISPLAY_TITLE}
            <div class="w-100 mb-1 block-title no-line">{$BLOCK.TITLE}</div>
        {/if}
        <div class="w-100 map-canvas" id="map-canvas-{$BLOCK.ID}"></div>
    </div>
</div>
<textarea id="gMapContent-{$BLOCK.ID}" class="d-none">
    <div class="fw-bold mb-1">{$SETTING.MAP_HTML_CODE}</div>
    <a target="_blank" href="//www.google.com/maps/dir//{$SETTING.GOOGLE_COORDINATE_Y},{$SETTING.GOOGLE_COORDINATE_X}/@{$SETTING.GOOGLE_COORDINATE_Y},{$SETTING.GOOGLE_COORDINATE_X},18z" class=" btn btn-outline-primary fw-bold text-content text-uppercase mr-1
        map-link">{#address_description#}</a>
</textarea>
{/if}