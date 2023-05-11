class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url

 private
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admin_path
    else
      root_path
    end

  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  def admin_url
    request.fullpath.include?("/admin")
  end

end