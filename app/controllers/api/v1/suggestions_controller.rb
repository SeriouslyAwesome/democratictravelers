class API::V1::SuggestionsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :check_honeypot, only: :create

  def index
    @experiences = Experience.full_list
  end

  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.user_id = @user.id
    if @suggestion.submit
      @location = @suggestion.location
      @experience = @suggestion.experience
    else
      render json: { errors: @suggestion.errors.to_a.to_sentence }
    end
  end

  private

  def suggestion_params
    params.require(:suggestion).permit(
      :location_name, :latitude, :longitude, :address, :formatted_address,
      :city, :state, :zip, :experience_name, :description
    )
  end
end
