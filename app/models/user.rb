class User < ApplicationRecord
    class User < ApplicationRecord
        validates :username,presence: true, uniqueness: true,format: {without: /[<>]/, message: "symbols '<' and '>' are not valid" }
        validates :full_name, presence: true
        has_many :opinions, dependent: :delete.all 
        has_many :followers, class_name:  'following', foreign_key: 'follower_id',dependent: :destroy
        has_many :followee, class_name:  'following', foreign_key: 'followee_id',dependent: :destroy
        has_many :followers, through: :followees, source: :follower
        has_many :followees, through: :followers, source: :followee
    
      def followees_opinions
        ids = follows.select(:id).ids
        ids << id
        Opinion.ordered_opinion.include_user_copied.user_filter_Opinion(User.user_and_following(ids))
      end
    
      def who_follow
        ids = follows.select(:id).ids
        ids << id
        User.ordered_users.user_who_follow(ids)
      end
    
      def unfollow(user)
        follows.destroy(user)
      end
    
      def copy_op(op)
        copy_opinion = if op.copied_id.nil? || op.created_at != op.updated_at
                         opinions.build(text: op.text, copied_id: op.user_id)
                       else
                         opinions.build(text: op.text, copied_id: op.copied_id)
                       end
        copy_opinion.save
      end
    
      scope :ordered_users, -> { order(created_at: :desc) }
      scope :user_and_following, ->(ids) { where(id: ids) }
      scope :user_who_follow, ->(ids) { where.not(id: ids) }
    end
end
