class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  # redirect to login if not logged in
  def authorize
    redirect_to '/login' unless logged_in
  end
end
