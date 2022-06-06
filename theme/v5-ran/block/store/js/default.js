let gMapScript = document.createElement('script');
const gMapKey = SETTING.GOOGLE_MAPS_API_KEY;

if (gMapKey) {

    gMapScript.src = `https://maps.googleapis.com/maps/api/js?key=${gMapKey}&sensor=true&libraries=geometry,places&callback=gMapsCallback${BLOCK.ID}`;
    document.head.appendChild(gMapScript);
    
    window[`gMapsCallback${BLOCK.ID}`] = function() {
        /* Big Map Codes */
        const latX = SETTING.GOOGLE_COORDINATE_X || 38.963745;
        const latY = SETTING.GOOGLE_COORDINATE_Y || 35.243322;
        const mapZoom = Number(SETTING.ZOOM || 6);
        const LatlngBig = new google.maps.LatLng(latX, latY);
        let mapOptions = {
            center: LatlngBig,
            zoom: T.isMobile() ? (mapZoom / 1.3) : mapZoom,
        };
        const mapBig = new google.maps.Map(document.getElementById(`store-map-canvas-${BLOCK.ID}`), mapOptions);
        /* Big Map Codes */
    
        /* Mini Maps Add */
        const canvasMaps = document.querySelectorAll('.map-canvas');
        const markers = [];
        for (i = 0; i < canvasMaps.length; i++) {
            let that = canvasMaps[i];
            let mapId = that.dataset.id;
            let mapName = that.dataset.name;
            let x = Number(latX);
            let y = Number(latY);
            let message = document.getElementById(`gMapContent-${mapId}`).value
            storeMaps = new google.maps.Marker({
                position: { lat: x, lng: y },
                map: mapBig,
                title: mapName
            });
            markers.push(storeMaps);
            let Latlng = new google.maps.LatLng(x, y);
            let mapOptions = {
                center: Latlng,
                zoom: 13,
            };
            let mapSmall = new google.maps.Map(document.getElementById(`store-map-canvas-${mapId}`), mapOptions);
            marker = new google.maps.Marker({
                position: Latlng,
                map: mapSmall,
                title: mapName
            });
            addInfoWindow(storeMaps, message);
        }
        function addInfoWindow(marker, message) {
            let infoWindow = new google.maps.InfoWindow({
                content: message
            });
            google.maps.event.addListener(marker, 'click', function () {
                infoWindow.open(mapBig, marker);
            });
        }
        /* Mini Maps Add */
    
        /* find nearest markers */
        if (!T.isMobile()) {
            const location = document.getElementById('maps-location-pos');
            mapBig.controls[google.maps.ControlPosition.TOP_RIGHT].push(location);
        }
        document.getElementById('nearest-location-button').addEventListener('click', function() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                (position) => {
                    const pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude,
                    };
                    mapBig.setCenter(pos);
                    mapBig.setZoom(14);
                    findMaker(pos);
                },
                () => {
                    handleLocationError(true, infoWindow, mapBig.getCenter());
                }
                );
            } else {
                handleLocationError(false, infoWindow, mapBig.getCenter());
            }
        });
        function rad(x) {return x*Math.PI/180;}
        function findMaker(pos) {
            var lat = pos.lat;
            var lng = pos.lng;
            var R = 6371;
            var distances = [];
            var closest = -1;
            for( i=0;i<markers.length; i++ ) {
                var mlat = markers[i].position.lat();
                var mlng = markers[i].position.lng();
                var dLat  = rad(mlat - lat);
                var dLong = rad(mlng - lng);
                var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                    Math.cos(rad(lat)) * Math.cos(rad(lat)) * Math.sin(dLong/2) * Math.sin(dLong/2);
                var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
                var d = R * c;
                distances[i] = d;
                if ( closest == -1 || d < distances[closest] ) {
                    closest = i;
                }
            }
            google.maps.event.trigger(markers[closest], 'click');
        }
        /* find nearest markers */
    }

}

T(`.store-select-${BLOCK.ID}`).on('change', el => {
    const url = new URL(window.location.href),
          params = url.searchParams;
    if (el.target.name == 'country') {
        params.delete('city'); params.delete('town');
    } else if (el.target.name == 'city') {
        params.delete('town');
    }
    params.set(el.target.name, el.target.value);
    window.location.href = url.toString();
});

document.getElementById(`form-search-${BLOCK.ID}`).addEventListener('invalid', (function () {
    return function (e) {
        e.preventDefault();
        document.getElementById(`search-word-${BLOCK.ID}`).focus();
    };
})(), true);