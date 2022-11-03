class ApplicationController < ActionController::Base
# before_action :authenticate_user!
before_action :configure_permitted_parameters, if: :devise_controller?
include Pagy::Backend

helper_method :include_navbar?
def include_navbar?
controller_name != 'sessions' && controller_name != 'registrations' && controller_name != 'passwords'
end

protected

def configure_permitted_parameters
devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio])
devise_parameter_sanitizer.permit(:account_update, keys: %i[name photo bio])
end
end 
