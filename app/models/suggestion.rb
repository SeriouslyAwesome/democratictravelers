class Suggestion
  # ATTRIBUTES
  include ActiveModel::Model
  attr_accessor(
    :location,
    :location_name,
    :latitude,
    :longitude,
    :address,
    :formatted_address,
    :city,
    :state,
    :zip,
    :experience,
    :experience_name,
    :description,
    :user_id
  )

  # VALIDATIONS
  validates :location_name, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :experience_name, presence: true

  # INSTANCE METHODS
  def submit
    return false unless valid?
    find_state
    find_or_create_location
    create_experience
    @location.save!
    SuggestionMailer.delay.new_suggestion(@experience.id)
  end

  private

  def create_experience
    @experience = @location.experiences.create!(
      name: experience_name,
      description: description,
      user_id: user_id
    )
  end

  def find_or_create_location
    @location = Location.find_or_initialize_by(
      name: location_name, lat: latitude, long: longitude
    )
    @location.assign_attributes(
      address: address, city: city, state_id: @state.id, zip: zip,
      formatted_address: formatted_address
    )
    @location.save!
  end

  def find_state
    @state = State.find_by(abbr: state) || State.find_by(name: state)
  end
end
