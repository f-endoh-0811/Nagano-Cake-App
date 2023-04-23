class ApplicationController < ActionController::Base
 
  def after_sign_in_path(resource_or_scope)
    if resource_or_scope == :customer
      root_path
    elsif resource_or_scope == :admin
      admin_path
    end
    
  end
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
        root_path
    else
        new_admin_session_path
    end
  end
  
end