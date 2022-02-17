class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_should_be_admin
  
  def edit
    @role = Role.find(params[:id])
  end
  
  def update
    @role = Role.find(params[:id])

    if @role.update(role_params)
      redirect_to user_url(current_user)
    else
      render :edit, status: :bad_request
    end
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      flash[:success] = "Role added"
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to user_url(@user)}
      end
    else
      render :new, status: :bad_request
    end
  end
  
  private
  
  def role_params
    params.require(:role).permit(:kind)
  end
end