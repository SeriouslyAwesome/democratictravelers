class NullUser
  def name
    '[Deleted]'
  end

  def username
    'deleted'
  end

  alias_method :first_name, :name
  alias_method :last_name, :name
  alias_method :short_name, :name
end
