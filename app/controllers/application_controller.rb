class ApplicationController < ActionController::API

  def index
    render json: "hello, world"
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
