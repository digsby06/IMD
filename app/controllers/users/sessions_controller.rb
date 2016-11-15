class Users::SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(failed_auth_options)
    if sign_in(resource_name, resource)
      @user = current_user
      flash[:success] = 'User signed in successfully'
      redirect_to home_path
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to admin_url
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if current_user.nil?
      flash[:success] = 'User Loged out'
      redirect_to root_url
    end
  end

  def failure
    flash[:danger] = 'Invalid email/password combination'
    redirect_to admin_url
 end

  protected

  def failed_auth_options
   { :scope => resource_name, :recall => "#{controller_path}#failure" }
  end
end
