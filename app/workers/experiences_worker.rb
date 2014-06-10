class ExperiencesWorker
  include Sidekiq::Worker

  def perform(location_id)
    location = Location.find(location_id)
    Experience.find_each do |exp|
      distance = exp.location.distance_from(location)
      exp.update_columns(distance: distance)
    end
  end
end
