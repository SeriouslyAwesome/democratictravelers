module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def reputation_for(_name)
    votes.sum(:value)
  end

  def add_or_update_evaluation(_name, value, user)
    vote = votes.find_or_initialize_by(user_id: user.id)
    vote.value = value
    vote.save!
  end

  def evaluations
    votes
  end
end
