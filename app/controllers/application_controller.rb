class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private
  
  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_admin_user
    if current_user && current_user.role_id==1
      return true
    else
      flash[:notice] = 'You are not authorized to view this content, please login as Admin'
      redirect_to root_path
    end
  end
  
  def require_normal_user
    if current_user && current_user.role_id==2
      return true
    else
      flash[:notice] = 'You are not authorized to view this content, please login.'
      redirect_to root_path
    end
  end  
end
