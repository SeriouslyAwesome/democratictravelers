module HomeHelper
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
