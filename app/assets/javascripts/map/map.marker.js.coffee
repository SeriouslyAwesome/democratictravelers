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
    DemocraticTravelers.Map.markers.push(marker)
    # Bind popup to marker
    popupContent = "<h4>#{loc.name}<br><small>#{loc.city}, #{loc.state}</small></h4>"
    titleContent = "What to do at #{loc.name} in #{loc.city}, #{loc.state} | The Democratic Travelers"

    marker.bindPopup popupContent, { offset: [0,-36] }
    marker.on 'click', ->
      @openPopup()
      DemocraticTravelers.Map.Router.navigate("/map/locations/#{this.options.id}", titleContent)
    marker.on 'popupclose', ->
      DemocraticTravelers.Map.Router.navigate("/map", "The Map | The Democratic Travelers")
      DemocraticTravelers.Map.Experiences.filterList()