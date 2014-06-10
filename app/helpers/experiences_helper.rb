# Used for the map, mostly.
module ExperiencesHelper
  def experience_description(experience)
    if experience.description.present?
      content_tag :p do
        content_tag(:strong, 'Why: ') + '#{experience.description}'
      end
    end
  end

  def voted_up?(experience)
    check_latest_vote_value(experience, 1)
  end

  def voted_down?(experience)
    check_latest_vote_value(experience, -1)
  end

  def voted_status_label(experience)
    if voted_up?(experience) || voted_down?(experience)
      if voted_up?(experience)
        label = content_tag(:span, 'Yay', class: 'label label-success')
      elsif voted_down?(experience)
        label = content_tag(:span, 'Nay', class: 'label label-danger')
      end

      content_tag(:p, class: 'muted voted-status-label') do
        "(You voted #{label} on this)".html_safe
      end
    end
  end

  def blog_post_link(experience)
    if experience.posts.any?
      content_tag :p do
        link_to('Read the Blog Post', post_path(experience.posts.first))
      end
    end
  end

  private

  def check_latest_vote_value(experience, value)
    evaluations = experience.evaluations.sort_by { |e| -e[:created_at].to_i }
    vote = evaluations.select { |e| e.source_id == current_user.id }.first
    (vote && most_recent_vote.value == value) ? true : false
  end
end
