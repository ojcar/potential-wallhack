class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
  	@current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def authenticate params
  	email = params[:email]
  	user = User.where(email: email).first_or_create
  	
  	role = Role.where(name: 'applicant')
  	user.roles << role

  	session[:current_user_id] = user.id
  end

  def login
  	authenticate
  	redirect_to quiz_index_path
  end

  def logged_in?
  	# !session[:current_user_id].nil?
  	!current_user.nil?
  end

  helper_method :current_user
end
