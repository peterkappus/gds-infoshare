class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #export our helper methods
  helper_method :signed_in?, :current_user, :is_admin?

  before_filter :check_login#, :except=>:about

  #admin methods
  def is_admin?
    signed_in? && current_user.admin?
  end

  # Get last day of financial year from a given date
  def fy_end(date)
    year = date.year
    # are we in the first three months of the year?
    if(date.month < 4)
      Date.new(date.year,3,31)
    else
      Date.new(date.year+1,3,31)
    end
  end

  def check_admin
    if !is_admin?
      flash['error'] = "The action you've requested requires admin privileges. "
      redirect_to root_path
    end
  end


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

  def current_user
    User.find_by(:email=>session['user_email'])
  end

end
