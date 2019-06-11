class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_request_filter

  def set_request_filter
    Thread.current[:request] = request
  end

  def after_sign_in_path_for(resource)
      root_path
  end

  private
      def sign_in_required
          redirect_to new_user_session_url unless user_signed_in?
      end
end
