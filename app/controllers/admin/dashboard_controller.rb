class Admin::DashboardController < AdminController
  def index
    @users = User.order('created_at DESC').limit(10).includes(:roles)
    @roles = Role.all
    @latest = Experience.order('created_at DESC').limit(25).includes(:location)

    @current = Location.where(current: true).first
    @closest = Experience.order('distance ASC').limit(25).includes(:location)
  end
end
