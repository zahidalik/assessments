class UserRolesController < ApplicationController
  def new
    @user = User.friendly.find(params[:user_id])
    @user_role = @user.user_roles.build
  end

  def create
    @user = User.friendly.find(params[:user_id])
    @user_role = @user.user_roles.build(user_roles_params)

    if @user_role.save
      respond_to do |format|
        format.turbo_stream
        format.html {redirect_to user_url(current_user)}
      end
    end
  end

  private

  def user_roles_params
    params.require(:user_role).permit(:role_id)
  end
end