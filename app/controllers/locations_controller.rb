class LocationsController < ApplicationController
  respond_to :html

  def index
    render 'home/map'
  end

  def show
    render 'home/map'
  end
end
