class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def search
    if params[:query].present?
      @users = User.where("full_name LIKE ? OR id = ?", "%#{params[:query]}%", params[:query].to_i)
    else
      @users = User.all
    end
    render :search_results
  end

  private

  def profile_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
