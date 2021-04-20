class FollowingsController < ApplicationController
    before_action :set_user, only: %i[create destroy]
    before_action :authenticate_user!

def create
@following = Following.new
if @following.build_saving(@user,current_user)
    flash[:notice] = 'Successfully following #{@user.username}'
else
    flash[:alert] = 'An error occured in following #{@user.username}'
end
redirect_to request.referer

def destroy
current_user.unfollow(@user)
flash[:notice] = 'unfollowing #{@user.username}'
redirect_to request.referer

end
private

def set_user
@user = user.find(params[:id])
end

def Following_params
    params.fetch(:following,{})
end
end