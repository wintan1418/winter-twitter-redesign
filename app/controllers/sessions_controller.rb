class SessionsController < ApplicationController
    before_action :set_user, only: %i[create]
    
    def new 
    end

      def create
        if @user
        session[:user_id] = @user.id
        session[:username] = @user.username
        redirect_to_root_url, notice: 'yipee,you are logged in'

            else
             flash.now[:alert] = 'Username is not valid'
             render 'new'
            end
            end

        def destroy
            session[:user_id] = nil
            session[:username] = nil
            redirect_to_root_url, notice: 'you logged out'

        end

private

def set_user
    @user = User.find_by_username(params[:username])
rescue ActiveRecord::RecordNotFound
  @user = nil
end

end
