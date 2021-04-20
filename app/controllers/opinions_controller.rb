class OpinionsController < ApplicationController
    before_action :set_opinion, only: %i[show update edit destroy retweet]
    before_action :authenticate_user!, except: %i[index show]
    
    def index
        if current_user
          @opinions = current_user.followees_opinions
          @users = current_user.who_follow
        else
          @opinions = Opinion.ordered_opinion.include_user_copied
          @users = User.ordered_users
        end
        @opinion = Opinion.new
      end


end
