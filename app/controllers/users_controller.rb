class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:id])
    render 'home/map'
  end
end
