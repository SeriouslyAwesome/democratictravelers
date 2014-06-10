json.locations do
  json.array! @locations do |location|
    json.id location.id
    json.name location.name
    json.city location.city
    json.state location.state.abbr
    json.votes location.votes_cache
    json.experience_ids location.experiences.pluck(:id).to_a
  end
end