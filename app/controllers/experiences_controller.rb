class ExperiencesController < ApplicationController
  respond_to :html

  def show
    render 'home/map'
  end
end
