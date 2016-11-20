class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #export our helper method
  helper_method :signed_in?

  before_filter :check_login, :except=>:about

  def signed_in?
    #current_user && !current_user.name.to_s.empty? && !current_user.email.to_s.empty?
    !session['user_email'].to_s.empty?
  end

  def check_login
    if !signed_in?
      session[:previous_url] = request.path
      render "info/index"
      return
    end
  end

end
