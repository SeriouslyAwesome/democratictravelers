DemocraticTravelers.Map =
  Search: {}
  Marker: {}
  Auth: {}
  # Set up global necessities for map functionality
  mapObject: null
  searchLayer: null
  locationsLayer: null

  initialize: ->
    # Initialize Mapbox Map
    @mapObject = L.mapbox.map 'map', 'seriouslyawesome.i675cgi9',
      minZoom: 4
      maxZoom: 12

    # Center on the US, then offset by 15% to the left to account for sidebar.
    @mapObject.setView([37.09024, -95.71289100000001], 4)
    offset = @mapObject.getSize().x * 0.15
    @mapObject.panBy new L.Point(offset, 0),
      animate: false
      
    # Move zoomControl to a custom position
    @mapObject.zoomControl.setPosition 'bottomleft'

    @locationsLayer = L.layerGroup().addTo(@mapObject)
    
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
        
    currentMarker.addTo(@mapObject)
        
    # Initialize list filtering on map move
    @experienceList = $('.suggestion').not('#new-suggestion')
    @mapObject.on 'moveend', =>
      inBounds = []
      bounds = @mapObject.getBounds()

      @locationsLayer.eachLayer (marker) ->
        if bounds.contains marker.getLatLng()
          inBounds.push marker.options.id

      @experienceList.hide()
      for id in inBounds
        @experienceList.filter("[data-location-id=#{id}]").show()

    # Setup Map/List view toggler
    $('#show-map, #show-list').click ->
      DemocraticTravelers.Map.toggleView this

    @Search.initialize(@mapObject)
    @Auth.initialize()
    DemocraticTravelers.Suggestion.initialize()
    DemocraticTravelers.Router.start()

  toggleView: (button) ->
    $(button).hide()
    $(button).siblings().show()
    $('#map-list').slideToggle('fast')

  toggleForm: ->
    $('#new-suggestion').slideToggle('fast').reset()

  renderMarkers: (locations) ->
    for location in locations
      @Marker.render(location)
