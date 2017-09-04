class UsersController < ApplicationController

  before_action :return_unless_loggedin , only: [:info, :logout]

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { hasura_id: user.hasura_id, create_session: true }
    else  
      render json: { code: "unauthorized", message: "Unable to authenticate user" }, status: 401
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def signup
    hasura_id = params[:hasura_id]
    email = params[:data][:email]
    password = params[:data][:password]
    user = User.new(email: email, password: password, hasura_id: hasura_id)
    if user.save
      session[:user_id] = user.id
      render json: { hasura_id: user.hasura_id, create_session: false, merge_data: {email: email}, new_user: true }, status: 201
    else
      render json: { code: "bad_request", message: user.errors.full_messages.join(";") }, status: 400
    end
  end

  def merge
    old_hasura_id = params[:old_hasura_id]
    new_hasura_id = params[:new_hasura_id]
    user = User.find_by(hasura_id: old_hasura_id)
    user.hasura_id = new_hasura_id
    if user.save(validate:false)
      render json: {success: true}
    else 
      render json: { code: "bad_request", message: user.errors.full_messages.join(";") }, status: 400
    end
  end

  def info
    hasura_id = current_user.hasura_id
    email = current_user.email
    render json: { hasura_id: hasura_id, email: email }
  end

private

  def logged_in?
    !!current_user
  end

  def return_unless_loggedin
    unless logged_in?
      render json: { message: "Not logged-in" }, status: 401
    end
  end

end
