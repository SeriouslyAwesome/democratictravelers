class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def dashboard
    @users = User.order('created_at DESC').limit(10).includes(:roles)
    @roles = Role.all
    @latest = Experience.order('created_at DESC').limit(25).includes(:location)

    @current = Location.where(current: true).first
    @closest = Experience.order('distance ASC').limit(25).includes(:location)
  end
end
