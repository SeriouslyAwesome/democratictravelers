class Admin::LocationsController < AdminController
  respond_to :json

  def create
    address = params[:location][:formatted_address]
    @location = Location.where(formatted_address: address)
      .first_or_initialize(location_params)
    @location.state = find_state
    if @location.save!
      reset_non_current_locations(@location)
      ExperiencesWorker.perform_async(@location.id)
      render json: { success: true }
    end
  end

  private

  def location_params
    params.require(:location).permit(
      :name, :lat, :long, :formatted_address, :address1, :city, :current
    )
  end

  def find_state
    # Find the state ID from the form data
    State.find_by_abbr(params[:state]) || State.find_by_name(params[:state])
  end

  def reset_non_current_locations(location)
    # Set any previous "current" location to false
    Location.where(current: true).find_each do |l|
      l.update_columns(current: false)
    end

    location.update_columns(current: true)
  end
end
