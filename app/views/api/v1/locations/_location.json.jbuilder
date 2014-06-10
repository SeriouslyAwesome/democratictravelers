json.type 'Feature'

json.geometry do
  json.type 'Point'
  json.coordinates [location.long, location.lat]
end

json.properties do
  json.name location.name
  json.votes location.votes_cache
  json.done location.done?
end