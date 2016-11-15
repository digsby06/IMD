class Users::PasswordsController < Devise::PasswordsController
  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    admin_url
  end

  def after_resetting_password_path_for(resource)
      Devise.sign_in_after_reset_password ? home_url : new_session_path(resource_name)
    end
end
