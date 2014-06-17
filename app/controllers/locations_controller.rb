class LocationsController < ApplicationController
  respond_to :html

  def index
    render 'home/map'
  end

  def show
    @location = Location.find(params[:id])
    render 'home/map'
  end
end
