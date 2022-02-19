class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = "Successfully logged in"
      redirect_to teachers_url
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new, status: :bad_request
    end
  end

  def destroy
    log_out
    flash[:notice] = "Successfully logged out"
    redirect_to root_url, status: :see_other
  end
end