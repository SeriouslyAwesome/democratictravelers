require 'multi_json'
MultiJson.use :yajl

json.cache! @experiences.first do
  json.success true
  json.locations do
    json.partial! 'api/v1/locations/locations', locations: @experiences.map(&:location).uniq
  end

  json.experiences do
    json.partial! 'api/v1/experiences/experiences', experiences: @experiences
  end
end