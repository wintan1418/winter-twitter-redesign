  
class Following < ApplicationRecord
    validates :follower, presence: true
    validates :followee, presence: true
    belongs_to :follower, class_name: 'User'
    belongs_to :followed, class_name: 'User'
  
    def build_saving(user, current)
      return false if user == current
  
      return false unless Following.find_by(follower: current, followee: user).nil?
  
      self.follower = current
      self.followee = user
      save
    end
  end