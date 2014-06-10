class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      successful_response(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def sign_up_params
    generate_password if conversion?
    params.require(:user).permit(
      :name, :email, :username, :password, :password_confirmation,
      :mailing_list
    )
  end

  def conversion?
    params[:user][:password].blank? &&
      params[:user][:password_confirmation].blank?
  end

  def generate_password
    @password = SecureRandom.base64(9)
    params[:user][:password] = @password
    params[:user][:password_confirmation] = @password
  end

  def successful_response(resource)
    set_flash_message :notice, :signed_up if is_flashing_format?
    sign_up(resource_name, resource)

    respond_to do |format|
      format.json do
        render json: json_response(resource)
      end
      format.html { redirect_to after_sign_up_path_for(resource) }
    end
  end

  def json_response(resource)
    greet = "Hey #{resource.first_name}! Welcome! #{sign_out_link}"

    {
      success: true, conversion: conversion?, greeting: greet,
      api_key: resource.authentication_token, user_id: resource.uuid
    }
  end
end
