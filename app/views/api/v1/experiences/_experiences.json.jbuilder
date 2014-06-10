json.array! experiences do |experience|
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