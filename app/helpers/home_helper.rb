module HomeHelper
  def map_meta
    if @user
      title "#{@user.short_name}'s Suggestions"
      meta_description "Check out where #{@user.first_name} thinks we should go. Vote for the best ideas."
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

  def traveling_for
    @traveling_for ||= distance_of_time_in_words(Date.new(2013, 02, 01), Date.today)
  end

  def state_count
    State.where(done: true).count
  end

  def completed_count
    Experience.done.count
  end
end
