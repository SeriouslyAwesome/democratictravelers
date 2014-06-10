dtr = DemocraticTravelers.Router
api = DemocraticTravelers.API

dtr.route '/map', ->
  api.getJSON 'experiences'

dtr.route '/map/ambassadors/:id', (id) ->
  api.getJSON "users/#{id}"

dtr.route '/map/locations/:id', (id) ->
  api.getJSON "locations/#{id}"

dtr.route '/map/:id', (id) ->
  api.getJSON "experiences/#{id}"

dtr.route '/map/current', ->
  api.getJSON 'locations/current'
