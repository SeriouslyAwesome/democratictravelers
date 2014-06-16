DemocraticTravelers.Map.CurrentLocation =
  init: ->
    # Add "current location" marker
    currentLat = $('#map').data('current-latitude')
    currentLong = $('#map').data('current-longitude')
    currentMarker = L.marker [currentLat, currentLong],
      title: 'Current Location'
      icon: L.divIcon
        className: 'map-pin-current'
        html: '<div class="map-pin"><span><i class="fa fa-compass fa-lg"></i></span></div><div class="pulse"></div>'
        iconSize: [40,51]
        iconAnchor: [20,46]

    currentMarker.addTo(DemocraticTravelers.Map.mapObject)