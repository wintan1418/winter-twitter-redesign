class ApplicationController < ActionController::Base
helper_method :current_user

def current_user
    if_session[:user_id]
    @current_user ||= user.find(session[:user_id])
else
    @current_user = nil
end
end

def authenticate_user!
return unless session[:user_id].nil?
flash[:alert] = 'Please log in before you continue'
redirect_to root_url

end
end

