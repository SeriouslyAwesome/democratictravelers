json.files do
  json.array! Array(@asset) do |asset|
    json.id asset.id
    json.name asset.asset
    json.size asset.filesize
    json.url asset.asset.url
    json.alt asset.alt_name
    json.thumbnail_url asset.asset.thumb.url
    json.cover_url admin_asset_toggle_cover_path(asset_id: asset.id)
    json.delete_url admin_asset_path(id: asset.id)
  end
end