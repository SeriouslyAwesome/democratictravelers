# Static pages.
class HomeController < ApplicationController
  respond_to :html, :xml
  def index
    @current = Location.current
    @post = Post.published.first
  end

  def map
    # Nothin' to do! Hooray!
  end

  def about
    @states = State.where(done: true)
    @finished = Experience.done
  end

  def colophon
    @users = User.order('created_at DESC').registered
  end

  def sitemap
    p = Post.published.first
    e = Experience.order('created_at DESC').first

    @pages = [home_xml, map_xml(e), blog_xml(p), about_xml(p)]
    @pages += posts_xml
    @pages += experiences_xml
    @pages += users_xml

    respond_to do |format|
      format.xml
    end
  end

  private

  def home_xml
    {
      url: '/',
      updated_at: xml_date(Location.current.updated_at),
      changefreq: 'daily',
      priority: '1.0'
    }
  end

  def map_xml(exp)
    {
      url: map_path,
      updated_at: xml_date(exp.created_at),
      changefreq: 'daily',
      priority: '1.0'
    }
  end

  def blog_xml(post)
    {
      url: posts_path,
      updated_at: xml_date(post.published_at),
      changefreq: 'daily',
      priority: '1.0'
    }
  end

  def about_xml(post)
    {
      url: about_path,
      updated_at: xml_date(post.published_at),
      changefreq: 'weekly',
      priority: '1.0'
    }
  end

  def posts_xml
    Post.published.all.map do |p|
      {
        url: post_path(p),
        updated_at: xml_date(p.published_at),
        changefreq: 'daily',
        priority: '0.7'
      }
    end
  end

  def experiences_xml
    Experience.popular.map do |e|
      {
        url: experience_path(e),
        updated_at: xml_date(e.created_at),
        changefreq: 'daily',
        priority: '0.6'
      }
    end
  end

  def users_xml
    User.all.map do |u|
      {
        url: "/map/ambassadors/#{u.uuid}",
        updated_at: xml_date(u.created_at),
        changefreq: 'daily',
        priority: '0.5'
      }
    end
  end

  def xml_date(time)
    time.strftime('%Y-%m-%dT%H:%M:%S+00:00')
  end
end
