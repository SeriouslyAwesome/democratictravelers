module AdminHelper
  def admin_sidebar
    render partial: "admin/sidebars/#{controller.controller_name}" rescue nil
  end
end
