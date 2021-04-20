class Following < ApplicationRecord
    validates :follower, presence: true
    validates :followee, presence: true
    belongs to :follower, class_name: 'User'
    belongs to :followee, class_name: 'User'

    def build_saving(user,current)
        return false if user == current

        return false unless following.find_by(follower: current, followee: user).nil?
        self.follower = current
        self.followee =user
        save
    end
end
