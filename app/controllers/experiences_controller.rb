class ExperiencesController < ApplicationController
  respond_to :html

  def show
    @experience = Experience.friendly.find(params[:id])
    render 'home/map'
  end
end
