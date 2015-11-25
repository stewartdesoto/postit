class Post < ActiveRecord::Base
  
  include Votable #module has 1:M, and instance methods
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  before_save :generate_slug

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true


  def to_param
    self.slug
  end

  private

    def generate_slug
      temp_slug = self.title.gsub(/\W+/, '-').downcase
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