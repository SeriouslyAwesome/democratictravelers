class Admin::ExperiencesController < AdminController
  respond_to :json

  def toggle
    @experience = Experience.find(params[:experience_id])
    if params[:done] == 'true'
      @experience.mark_done
    else
      @experience.update_attributes(done: false)
    end

    render json: { success: true }
  end

  def destroy
    @experience = Experience.friendly.find(params[:id])
    if @experience.destroy
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
