class Comment < ActiveRecord::Base

  include Votable

  belongs_to :post
  belongs_to :user
  validates :body, presence: true

end