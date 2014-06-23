dtr = DemocraticTravelers.Map.Router
api = DemocraticTravelers.API

dtr.route '/map', ->
  DemocraticTravelers.Map.Experiences.filterList()

dtr.route '/map/ambassadors/:id', (id) ->
  id = id.split('?')[0]
  DemocraticTravelers.Map.Experiences.filterList("[data-user-id=\"#{id}\"]")

dtr.route '/map/locations/:id', (id) ->
  id = id.split('?')[0]
  DemocraticTravelers.Map.Experiences
    .filterList("[data-location-id=\"#{id}\"]")
  DemocraticTravelers.Map.locationsLayer.eachLayer (marker) ->
    if marker.options.id == parseInt(id)
      marker.openPopup()
      return false

dtr.route '/map/:id', (id) ->
  id = id.split('?')[0]
  DemocraticTravelers.Map.Experiences
    .filterList("[data-experience-id=\"#{id}\"]")
  locationId = $(".suggestion[data-experience-id=\"#{id}\"]").data('location-id')
  DemocraticTravelers.Map.locationsLayer.eachLayer (marker) ->
    if marker.options.id == parseInt(locationId)
      marker.openPopup()
      return false
