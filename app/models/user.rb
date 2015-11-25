class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  before_save :generate_slug
  
  def to_param
    self.slug
  end

  private

    def generate_slug
      self.slug = self.username.gsub(' ','_').downcase
    end
end