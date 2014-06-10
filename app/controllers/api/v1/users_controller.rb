class API::V1::UsersController < ApplicationController
  before_action :authenticate_user_from_token!

  def show
    @user = User.find_by(username: params[:id])
    @experiences = @user.experiences
    @locations = @experiences.map(&:location)
  end
end
