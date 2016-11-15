class Users::RegistrationsController < Devise::RegistrationsController

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(:user, @user)
      flash[:success] = 'User registrated successfully.'
      redirect_to home_url
    else
      flash[:danger] = "User registrated failed."
      render "new"
    end
  end

  protected

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation)
  end

end
