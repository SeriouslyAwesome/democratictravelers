class Admin::StatesController < AdminController
  respond_to :json
  def toggle
    @state = State.find(params[:state_id])
    if @state.update_attributes done: params[:done]
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
