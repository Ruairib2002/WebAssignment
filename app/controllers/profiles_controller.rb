class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end