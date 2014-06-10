class API::V1::SuggestionsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!
  before_action :check_honeypot, only: :create

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

  def notice
    if @experience.user.guest?
      'Sweet! Thanks! We\'d love to give credit where credit is due, though.
        If you give us your name and email, we\'ll set you up with an account
        and we\'ll be able to email you if/when we take you up on the
        suggestion and likewise when we write about it on the blog.'
    else
      'Awesome! Thanks for the tip!'
    end
  end

  def suggestion_params
    params.require(:suggestion).permit(
      :location_name, :latitude, :longitude, :address, :formatted_address,
      :city, :state, :experience_name, :description
    )
  end
end
