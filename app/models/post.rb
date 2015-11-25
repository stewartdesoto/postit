class Post < ActiveRecord::Base
  
  #include Votable
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  has_many :votes, as: :votable

  before_save :generate_slug

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true


    
  def net_votes
    up_votes - down_votes
  end

  def to_param
    self.slug
  end

  private

    def up_votes
      self.votes.where(vote: true).count
    end

    def down_votes
      self.votes.where(vote: false).count
    end

    def generate_slug
      temp_slug = self.title.gsub(/\W+/, '_').downcase
      while(post = Post.find_by(slug: temp_slug)) 
        mat = /\d+\z/.match(temp_slug)
        if mat
          temp_slug = mat.pre_match + '-' + ((mat.to_s.to_i)+1).to_s
        else
          temp_slug += '-1'
        end
      end
      self.slug = temp_slug
    end

end