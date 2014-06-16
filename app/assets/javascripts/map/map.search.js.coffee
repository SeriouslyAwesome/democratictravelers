DemocraticTravelers.Map.Search =
  initialize: (map) ->
    # Setup Google Places Autocomplete API
    search = document.getElementById 'location-search'
    autocomplete = new google.maps.places.Autocomplete search,
      componentRestrictions:
          country: 'us'

    # Setup a dedicated layer for the search results
    DemocraticTravelers.Map.searchLayer = L.layerGroup().addTo(map)

    # When a place is selected from the autocomplete list:
    google.maps.event.addListener autocomplete, 'place_changed', =>
      # Grab the deets
      place = autocomplete.getPlace()
      @selectPlace(place)

  selectPlace: (place) ->
    # Stash the location information from Google's wonky attribtutes
    coordinates = [place.geometry.location.k, place.geometry.location.A]
    address = {}

    jQuery.each place.address_components, (k,v1) ->
      jQuery.each v1.types, (k2, v2) ->
        address[v2] = v1.long_name

    @setFormFields(place, coordinates, address)

    @showOnMap(coordinates)

  setFormFields: (place, coordinates, address) ->
    $('#suggestion_location_name').val('').val(place.name)
    $('#suggestion_latitude').val('').val(coordinates[0])
    $('#suggestion_longitude').val('').val(coordinates[1])
    $('#suggestion_formatted_address').val('').val(place.formatted_address)

    if (typeof address.sublocality != 'undefined')
      $('#suggestion_city').val('').val(address.sublocality)
    else
      $('#suggestion_city').val('').val(address.locality)

    $('#suggestion_state').val('').val(address.administrative_area_level_1)

    if (typeof address.street_number != 'undefined')
      streetAddress = address.street_number + ' ' + address.route
      $('#suggestion_address').val('').val(streetAddress)

  showOnMap: (coordinates) ->
    # Clear previous search result
    DemocraticTravelers.Map.searchLayer.clearLayers()

    # Generate a marker for the searched location
    searchMarker = L.marker coordinates,
      icon: L.divIcon
        className: 'map-pin map-pin-search'
        html: '<span><i class="fa fa-search"></i></span>'
        iconSize: [40,51]
        iconAnchor: [20,46]

    # Add the search marker to the map and zoom to it.
    searchMarker.addTo(DemocraticTravelers.Map.searchLayer)
    DemocraticTravelers.Map.mapObject.setView coordinates, 12
