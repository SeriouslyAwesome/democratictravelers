(function() {
  $(document).ready(function() {
    if ($('#home-map-object').length) {
      var currentLat = $('#home-map-object').data('current-latitude');
      var currentLong = $('#home-map-object').data('current-longitude');
      var currentCity = $('#home-map-object').data('current-city');
      var currentState = $('#home-map-object').data('current-state');
      var currentCoords = [currentLat, currentLong];
      var map = L.mapbox.map('home-map-object', 'seriouslyawesome.i675cgi9', {
        center: currentCoords,
        zoom: 4,
        touchZoom: false,
        scrollWheelZoom: false,
        doubleClickZoom: false,
        boxZoom: false,
        dragging: false,
        zoomControl: false,
        attributionControl: false
      });

      var currentMarker = L.marker(currentCoords, {
        title: 'Current Location',
        icon: L.divIcon({
          className: 'map-pin-current',
          html: '<div class="map-pin"><span><i class="fa fa-compass fa-lg"></i></span></div><div class="pulse"></div>',
          iconSize: [40, 51],
          iconAnchor: [20, 46]
        })
      });

      currentMarker.addTo(map);

      var popupContent = `<h5><small>Current Location:</small><br>${currentCity}, ${currentState}</h5><p><a href="/map">View the Map &raquo;</a></p>`;

      currentMarker.bindPopup(popupContent, { offset: [0, -36], closeOnClick: false });
      currentMarker.openPopup();
    }
  });
})();
