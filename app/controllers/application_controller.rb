class ApplicationController < ActionController::API
  def current_user
    User.find(request.headers['user_id']) || User.first
  end
end
