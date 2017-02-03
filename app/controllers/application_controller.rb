class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session
  def set_json
    request.format = :json
  end
end
