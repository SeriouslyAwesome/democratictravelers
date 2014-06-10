require 'multi_json'
MultiJson.use :yajl

json.cache! @experience do
  json.success true
  json.locations do
    json.partial! 'api/v1/locations/locations', locations: Array(@experience.location)
  end

  json.experiences do
    json.partial! 'api/v1/experiences/experiences', experiences: Array(@experience)
  end
end