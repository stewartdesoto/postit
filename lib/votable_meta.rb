module Votable
  # instance methods will become instance methods
  # and class methods will become class methods

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    # actually firing class method
    base.class_eval do
      my_class_method
    end
  end


  module InstanceMethods
    def up_votes
      self.votes.where(vote: true).size
    end

    def down_votes
      self.votes.where(vote: false).size
    end

    def net_votes
      self.up_votes - self.down_votes
    end
  end


  module ClassMethods
    def my_class_method
      puts "THIS IS A CLASS METHOD!"
      has_many :votes, as: :votable
    end
  end

end