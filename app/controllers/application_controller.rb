class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

   def after_sign_in_path_for(resource)
      if current_user
        flash[:notice] = "ログインに成功しました"
        posts_path
      else
        flash[:notice] = "新規登録完了しました。"
        posts_path
      end
    end

end
