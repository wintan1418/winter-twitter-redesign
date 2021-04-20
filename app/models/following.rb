class Following < ApplicationRecord
    validates :follower, presence: true
    validates :followed, presence: true
    belongs to :follower, class_name: 'User'
    belongs to :followed, class_name: 'User'

    def build_saving(user,current)
        return false if user == current

        return false unless following.find_by(follower: current, followed: user).nil?
        self.follower = current
        self.followed =user
        save
    end
end
