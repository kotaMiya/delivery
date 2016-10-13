class SessionsController < ApplicationController
  def new
  end
  
  def create
      user = User.find_by(email: params[:session][:email].downcase)
      driver = Driver.find_by(email: params[:session][:email].downcase)
      admin_user = Admin.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    elsif driver && driver.authenticate(params[:session][:password])
      log_in driver
      redirect_to driver
    elsif admin_user && admin_user.authenticate(params[:session][:password])
      redirect_to admin_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
