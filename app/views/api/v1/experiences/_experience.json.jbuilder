json.name experience.name
json.description experience.description
json.votes experience.votes_cache
json.done experience.done?
json.location do
  json.name experience.location.name
  json.city experience.location.city
  json.state experience.location.state.abbr
end