Date::DATE_FORMATS[:default] = '%B %d, %Y'

class ActiveSupport::TimeWithZone
  def as_json(_options = {})
    strftime('%B %d, %Y')
  end
end
