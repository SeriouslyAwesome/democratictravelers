(function() {
  DemocraticTravelers.Map.CurrentLocation = {
    init: function(map) {
      var currentLat = $('#map').data('current-latitude');
      var currentLong = $('#map').data('current-longitude');

      var el = document.createElement('div');
      el.className = 'map-pin-current';
      el.innerHTML = '<div class="map-pin"><span><i class="fa fa-compass fa-lg"></i></span></div><div class="pulse"></div>';

      new mapboxgl.Marker({ element: el, anchor: 'bottom' })
        .setLngLat([currentLong, currentLat])
        .addTo(map);
    }
  };
})();
