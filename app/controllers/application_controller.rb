class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  around_action :set_time_zone, if: :current_user

  def set_time_zone
    if user_signed_in?
      Time.use_zone(current_user.time_zone) { yield }
    else
      yield
    end
  end
end
