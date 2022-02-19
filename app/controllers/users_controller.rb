class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!
  before_action :user_should_be_admin

  def show
    @roles = @user.roles
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash.now[:notice] = "User account edited successfully"
      redirect_to user_url(current_user)
    else
      render :edit, status: :bad_request
    end
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:notice] = "User account created successfully"
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to user_url(current_user)}
      end
    else
      render :new, status: :bad_request
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
    UserRole.where(user_id: @user.id).each do |user_role|
      user_role.delete
    end
    if @user.delete
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to user_url(current_user)}
      end
    else
      flash.now[:alert] = "Couldnt't delete. Try once again."
      render :show, bad: :request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end
end