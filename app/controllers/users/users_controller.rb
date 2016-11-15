class Users::UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:destroy, :update]
  before_filter :find_user, except: [:new]

  def new
    @users = User.all
  end

  def update
    puts 'AAAA'*50
    @user.update_attributes!(user_params)
    puts 'CCCC'*50
    puts @user.inspect
    render :json => @upload.to_json
  end

  def destroy
    @user.destroy
    redirect_to new_user_path and return
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :email,
      :username)
  end

end
