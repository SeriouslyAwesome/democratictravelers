class Admin::AssetsController < AdminController
  respond_to :json

  def create
    @asset = Asset.new(asset_params)
    if @asset.save
      render 'create', formats: [:json]
    else
      render json: [@asset.as_json.merge(error: @asset.errors.to_a.to_sentence)]
    end
  end

  def toggle_cover
    @asset = Asset.find(params[:asset_id])
    if @asset.update cover: (@asset.cover? ? false : true)
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def destroy
    @asset = Asset.find(params[:id])
    render json: { success: true } if @asset.destroy
  end

  private

  def asset_params
    params.require(:asset).permit(:asset)
  end
end
