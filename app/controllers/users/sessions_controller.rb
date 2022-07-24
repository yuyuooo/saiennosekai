class Users::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_about_path(user), notice: 'ゲストユーザーでログインしました。'
  end

  def after_sign_in_path_for(resource)
    case resource
      when User
        user_about_path(current_user)
    end
  end

protected

  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
        redirect_to new_user_session_path
      end
    end
  end

end
