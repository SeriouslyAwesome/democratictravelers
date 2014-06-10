class API::V1::LocationsController < ApplicationController
  before_action :authenticate_user_from_token!

  def index
    @locations = Location.includes(:experiences)
      .where('experiences_count > ?', 0).all
    @experiences = Experience.all
  end

  def show
    @location = Location.includes(:state, experiences: :user).find(params[:id])
  end

  def current
    @location = Location.current
  end
end
