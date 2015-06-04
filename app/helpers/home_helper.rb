module HomeHelper
  def map_meta
    if @user
      user_meta
    elsif @experience
      experience_meta
    else
      default_meta
    end
  end

  def user_meta
    title "#{@user.short_name}'s Suggestions"
    meta_description "Check out where #{@user.first_name} thinks we should \
      go. Vote for the best ideas."
  end

  def experience_meta
    title "#{@experience.name}"
    meta_description 'Should we do this? Cast your vote.'
  end

  def default_meta
    title 'The Map'
    meta_description 'Suggest our next stop, and vote for other destinations.'
  end

  def day_count
    (Time.zone.now.to_date - start_date).to_i
  end

  def traveling_for
    @traveling_for ||= distance_of_time_in_words(start_date, Time.zone.today)
  end

  def state_count
    State.where(done: true).count
  end

  def completed_count
    Experience.done.count
  end

  def start_date
    Date.new(2013, 02, 01)
  end
end
