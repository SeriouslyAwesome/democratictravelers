module ApplicationHelper
  def title(title = nil)
    if title.present?
      content_for :title, title
    else
      if content_for?(:title)
        content_for(:title) + ' | The Democratic Travelers'
      else
        'A Crowd-sourced Airstream Adventure | The Democratic Travelers'
      end
    end
  end

  def meta_description(desc = nil)
    if desc.present?
      content_for :meta_description, desc
    else
      if content_for?(:meta_description)
        content_for(:meta_description)
      else
        'Vote on where our roadtrip goes next.'
      end
    end
  end

  def site_header_class
    'opaque' if params[:page]
  end

  def body_class
    "#{controller.controller_path.split('/').first}
     #{controller.controller_name}
     #{controller.action_name} #{'admin' if admin?}"
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      hard_wrap: true, filter_html: true, autolink: true,
      no_intraemphasis: true, fenced_code: true, gh_blockcode: true
    )

    markdown.render(text).html_safe
  end

  def admin?
    current_user && current_user.admin?
  end

  def email
    mail_to(
      'yourstruly@thedemocratictravelers.com',
      nil, encode: 'hex', replace_at: '-at-', replace_dot: '-dot-'
    )
  end

  def date(date)
    date.strftime('%B %d, %Y')
  end

  def ga_id
    Rails.env.development? ? 'UA-5828878-12' : 'UA-5828878-11'
  end
  
  def ga_domain
    if Rails.env.development?
      'democratictravelers.dev'
    else
      'thedemocratictravelers.com'
    end
  end

  # Devise form helpers
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def guest_user_conversion
    render 'devise/registrations/conversion.html.erb'
  end
end
