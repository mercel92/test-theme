if (T(`#swiper-${BLOCK.ID}`).length > 0 && T(`#swiper-${BLOCK.ID} .swiper-slide`).length > 1) {
    new Swiper(`#swiper-${BLOCK.ID}`, {
        navigation: {
            nextEl: `#swiper-next-${BLOCK.ID}`,
            prevEl: `#swiper-prev-${BLOCK.ID}`,
        },
    });
}

lightGallery(document.getElementById(`gallery-${BLOCK.ID}`), {
    actualSize : false,
    download : false,
    thumbnail: true,
    animateThumb: false,
    showThumbByDefault: true,
    thumbWidth : 80,
});

if (document.getElementById(`store-map-canvas-${BLOCK.ID}`) != null) {

    let gMapScript = document.createElement('script');
    const gMapKey = document.getElementById(`gMapKey-${BLOCK.ID}`).value;

    gMapScript.src = `https://maps.googleapis.com/maps/api/js?key=${gMapKey}&sensor=true&callback=gMapsCallback${BLOCK.ID}`;
    document.head.appendChild(gMapScript);

    window[`gMapsCallback${BLOCK.ID}`] = function(){
        var Latlng = new google.maps.LatLng(document.getElementById(`gMapX-${BLOCK.ID}`).value, document.getElementById(`gMapY-${BLOCK.ID}`).value);
        var mapOptions = {
            center: Latlng,
            zoom: 16
        };
        var map = new google.maps.Map(document.getElementById(`store-map-canvas-${BLOCK.ID}`), mapOptions);
        var infowindow = new google.maps.InfoWindow({
            content: document.getElementById(`gMapContent-${BLOCK.ID}`).value
        });
        marker = new google.maps.Marker({
            position: Latlng,
            map: map,
        });
        google.maps.event.addListener(marker, 'click', function(){
            infowindow.open(map, marker);
        });
        google.maps.event.trigger(marker, 'click');
    }

}
