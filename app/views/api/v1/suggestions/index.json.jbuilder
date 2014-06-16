require 'multi_json'
MultiJson.use :yajl

json.cache! @experiences.first do
  json.success true
  json.locations do
    json.array! @experiences.map(&:location).uniq do |location|
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
  end

  json.experiences do
    json.array! @experiences do |experience|
      json.id experience.id
      json.slug experience.slug
      json.name experience.name
      json.venue experience.venue
      json.city experience.city
      json.state experience.state.abbr
      json.description experience.description
      json.username experience.submitter.username
      json.userShortName experience.submitter.short_name
      json.date date(experience.created_at)
      json.votes experience.votes_cache
      json.votesText pluralize experience.votes_cache, 'Vote'
      json.upvoted experience.voted_up?(current_or_guest_user)
      json.downvoted experience.voted_down?(current_or_guest_user)
      json.locationId experience.location_id
      json.done experience.done?
    end
  end
end