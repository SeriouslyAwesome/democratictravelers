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
    if valid?
      find_or_create_location
      @experience = @location.experiences.create!(
        name: experience_name,
        description: description,
        user_id: user_id
      )
      @location.save!
      SuggestionMailer.delay.new_suggestion(@experience.id)
    end
  end

  private

  def find_or_create_location
    @state = State.find_by(abbr: state) || State.find_by(name: state)
    @location = Location.find_or_initialize_by(
      name: location_name, lat: latitude, long: longitude
    )
    @location.address = address
    @location.city = city
    @location.state_id = @state.id
    @location.zip = zip
    @location.formatted_address = formatted_address
    @location.save!
  end
end
