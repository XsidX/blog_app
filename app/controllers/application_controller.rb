class ApplicationController < ActionController::Base
  include Pagy::Backend
  def current_user
    @current_user = User.all.find(1)
  end
end
