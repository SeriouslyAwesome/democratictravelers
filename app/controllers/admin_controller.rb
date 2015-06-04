class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def dashboard
    @users = User.registered.order('created_at DESC').limit(50).includes(:roles)
    @roles = Role.all
    @latest = Experience.order('created_at DESC').limit(25).includes(:location)

    @current = Location.current
    @closest = Experience.order('distance ASC').limit(100).includes(:location)
  end
end
