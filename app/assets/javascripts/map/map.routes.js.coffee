dtr = DemocraticTravelers.Map.Router
api = DemocraticTravelers.API

dtr.route '/map', ->
  DemocraticTravelers.Map.Experiences.filterList()

dtr.route '/map/ambassadors/:id', (id) ->
  DemocraticTravelers.Map.Experiences.List.hide()
  DemocraticTravelers.Map.Experiences.List.filter("[data-user-id=#{id}]").show()

dtr.route '/map/locations/:id', (id) ->
  DemocraticTravelers.Map.Experiences.List.hide()
  DemocraticTravelers.Map.Experiences.List.filter("[data-location-id=#{id}]").show()
  
  DemocraticTravelers.Map.locationsLayer.eachLayer (marker) ->
    if marker.options.id == parseInt(id)
      marker.openPopup()
      return false
  #location = DemocraticTravelers.Map.markers.filter (m) ->
  #  m.options.id == parseInt(id)
  #location[0].openPopup()

dtr.route '/map/:id', (id) ->
  DemocraticTravelers.Map.Experiences.List.hide()
  DemocraticTravelers.Map.Experiences.List.filter("[data-experience-id=#{id}]").show()
  locationId = $(".suggestion[data-experience-id=#{id}]").data('location-id')
  DemocraticTravelers.Map.locationsLayer.eachLayer (marker) ->
    if marker.options.id == parseInt(locationId)
      marker.openPopup()
      return false
