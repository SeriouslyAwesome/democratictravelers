DemocraticTravelers.Map.Marker =
  render: (location) ->
    # Prep
    loc = location.properties
    if loc.done == true
      className = 'map-pin map-pin-done'
    else
      className = 'map-pin'

    # Create marker
    marker = L.marker location.geometry.coordinates.reverse(),
      title: loc.name
      id: loc.id
      icon: L.divIcon
        className: className
        html: "<span>#{loc.votes}</span>"
        iconSize: [40,51]
        iconAnchor: [20,46]

    marker.addTo(DemocraticTravelers.Map.locationsLayer)

    # Bind popup to marker
    popupContent = "<h4>#{loc.name}<br><small>#{loc.city}, #{loc.state}</small></h4>"

    marker.bindPopup popupContent,
      offset: [0,-36]
    marker.on 'mouseover', ->
      @openPopup()
    marker.on 'mouseout', ->
      @closePopup()
    marker.on 'click', ->
      @openPopup()
      DemocraticTravelers.Router.navigate("/map/locations/#{this.options.id}")