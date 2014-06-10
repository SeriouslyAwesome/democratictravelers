module PostsHelper
  def hero_image_tag_for(post)
    content_tag :div, class: 'post-hero' do
      html = ''
      if post.assets.any? && post.assets.cover.any?
        html << image_tag(post.assets.cover.first.asset.url)
      end
      html << content_tag(:div, nil, class: 'hero-chevron')
      raw(html)
    end
  end

  def title_tag_for(post)
    content_tag :span, post.title, itemprop: 'name'
  end

  def date_tag_for(post)
    content_tag :span, post.published_at
      .strftime('%B %-d, %Y'), itemprop: 'datePublished',
                               content: post.published_at.strftime('%Y-%m-%d')
  end

  def author_tag_for(post)
    content_tag :span, itemprop: 'author',
                       itemscope: '',
                       itemtype: 'http://schema.org/Person' do
      content_tag :span, post.author, itemprop: 'name'
    end
  end
end
