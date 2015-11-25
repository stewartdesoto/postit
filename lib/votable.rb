module Votable

  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def net_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).count
  end

  def down_votes
    self.votes.where(vote: false).count
  end


end