const gMapScript = document.createElement('script');
const gMapKey = SETTING.GOOGLE_MAPS_API_KEY;

if (gMapKey) {
    gMapScript.src = `https://maps.googleapis.com/maps/api/js?key=${gMapKey}&sensor=true&callback=gMapsCallback${BLOCK.ID}`;
    document.head.appendChild(gMapScript);
    window[`gMapsCallback${BLOCK.ID}`] = function(){
        T(window).trigger('gMapsLoaded');
        var Latlng = new google.maps.LatLng(SETTING.GOOGLE_COORDINATE_Y, SETTING.GOOGLE_COORDINATE_X);
        var mapOptions = {
            center: Latlng,
            zoom: 16,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById(`map-canvas-${BLOCK.ID}`), mapOptions);
        var infowindow = new google.maps.InfoWindow({
            content: document.getElementById(`gMapContent-${BLOCK.ID}`).value
        });
        marker = new google.maps.Marker({
            position: Latlng,
            map: map,
            title: ""
        });
        google.maps.event.addListener(marker, 'click', function(){
            infowindow.open(map, marker);
        });
        google.maps.event.trigger(marker, 'click');
    }
}
