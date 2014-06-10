json.success true

if @experience.user.guest?
  json.notice "<p>Thanks for the tip! We\'d love to give credit where is due, though. If you provide your name and email, we\'ll notify you if/when we take your suggestion and when we write about it on the blog.</p> #{guest_user_conversion}"
  json.showRegistrationForm true
else
  json.notice 'Thanks for the tip! Let the voting begin! We\'ll let you know if/when we take you up on the suggestion!'
end

json.locations do
  json.partial! 'api/v1/locations/locations', locations: Array(@location)
end

json.experiences do
  json.partial! 'api/v1/experiences/experiences', experiences: Array(@experience)
end