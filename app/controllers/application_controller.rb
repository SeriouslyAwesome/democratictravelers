class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  def after_sign_in_path_for(_resource)
    (current_user.admin? ? admin_path : map_path) unless json_request?
  end

  def after_sign_up_path_for(_resource)
    map_path unless json_request?
  end

  def after_sign_out_path_for(_resource)
    map_path
  end

  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        convert_user
        guest_user.destroy
        session[:guest_user_id] = nil
      end

      current_user
    else
      guest_user
    end
  end
  helper_method :current_or_guest_user

  def guest_user
    @guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    guest_user
  end

  protected

  def json_request?
    request.format.json?
  end

  def authorize_admin!
    if user_signed_in? && current_user.admin?
      return
    else
      render '/errors/error_404'
    end
  end

  def authenticate_user_from_token!
    uuid = request.headers['X-USER-ID'].presence
    api_key = request.headers['X-API-KEY'].presence
    @user = uuid && User.find_by(uuid: uuid)

    if @user && Devise.secure_compare(@user.authentication_token, api_key)
      sign_in @user, store: false unless user_signed_in?
    else
      head 401
    end
  end

  def sign_out_link
    view_context.link_to 'Sign out', destroy_user_session_path, method: :delete
  end

  private

  def convert_user
    experiences = guest_user.experiences.all
    experiences.each do |exp|
      exp.user_id = current_user.id
      exp.save!
    end

    evals = ReputationSystem::Evaluation.where(source_id: guest_user.id).all
    evals.each do |e|
      e.source_id = current_user.id
      e.save!
    end
  end

  def create_guest_user
    email = "guest_#{Time.now.to_i}#{rand(99)}@thedemocratictravelers.com"
    user = User.create(name: 'Anonymous', email: email, guest: true)
    user.save!(validate: false)
    session[:guest_user_id] = user.id
    user
  end

  def check_honeypot
    head 401 unless params[:comment_body].blank?
  end

  def admin?
    user_signed_in? && current_user.admin?
  end
end
