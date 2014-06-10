json.array! locations do |location|
  json.type 'Feature'

  json.geometry do
    json.type 'Point'
    json.coordinates [location.long, location.lat]
  end

  json.properties do
    json.id location.id
    json.name location.name
    json.city location.city
    json.state location.state.abbr
    json.votes location.votes_cache
    json.done location.done?
  end
end