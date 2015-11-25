class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :votes, as: :votable
  validates :body, presence: true

  def net_votes
    num=self.votes.where(vote: true).count -
         self.votes.where(vote: false).count
    num < 0 ? 0 : num
  end
end