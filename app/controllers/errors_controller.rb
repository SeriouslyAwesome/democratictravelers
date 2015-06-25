class ErrorsController < ApplicationController
  def error_404
    respond_to do |format|
      format.html { render status: 404 }
    end
  rescue ActionController::UnknownFormat
    render status: 404, text: 'Nope.'
  end

  def error_500
  end
end
