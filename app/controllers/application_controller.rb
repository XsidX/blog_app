class ApplicationController < ActionController::Base
  def current_user
    @current_user = User.all.find(1)
  end
end
