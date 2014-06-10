class API::V1::ExperiencesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :authorize_admin!, only: [:done, :destroy]
  before_action :find_experience, except: :index

  def index
    @experiences = Experience.full_list
  end

  def show
  end

  def update
    if @experience.user_id == @user.id
      @experience.update_attributes(experience_params)
    else
      head 403
    end
  end

  def upvote
    @experience.upvote(@user)
  end

  def downvote
    @experience.downvote(@user)
  end

  # ADMINS ONLY
  def done
    @experience.mark_done
  end

  def destroy
    @experience.destroy
    render nothing: true
  end

  private

  def find_experience
    @experience = Experience.friendly.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:name, :description)
  end

  def authorize_admin!
    head 403 unless @user.admin?
  end
end
