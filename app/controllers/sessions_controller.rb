class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = "Successfully logged in"
      if user.roles.any? {|role| role.kind == "super admin"} || user.roles.any? {|role| role.kind == "admin"}
        redirect_to user_url(user)
      else
        redirect_to teachers_url
      end
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