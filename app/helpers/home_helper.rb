module HomeHelper
  def map_meta
    if @user
      title "#{@user.short_name}'s Suggestions"
      meta_description "Check out where #{@user.first_name} thinks we should go. Vote for the best ideas."
    elsif @location
      title "What to do at #{@location.name} in #{@location.city}, #{@location.state.name}"
      meta_description "Should we go here? Cast your vote."
    elsif @experience
      title "#{@experience.name}"
      meta_description "Should we do this? Cast your vote."
    else
      title 'The Map'
      meta_description 'Suggest our next stop, and vote for other destinations.'
    end
  end

  def day_count
    (Time.now.to_date - Date.new(2013, 02, 1)).to_i
  end

  def state_count
    State.where(done: true).count
  end

  def completed_count
    Experience.done.count
  end
end
