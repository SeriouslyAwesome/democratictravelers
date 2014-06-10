class Admin::UsersController < AdminController
  respond_to :json
  def index
    @admins = User.with_role(:admin)
    @users = User.with_role(:user).order('created_at DESC')
    @roles = Role.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], as: :admin)
      redirect_to users_path, notice: 'User updated.'
    else
      redirect_to users_path, alert: 'Unable to update user.'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
