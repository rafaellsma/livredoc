module Api::V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    include ActionController::Serialization

    before_action :authenticate

    private

    def authenticate
      unless authenticate_token?
        render json: { message: 'Bad credentials' }, status: :unauthorized
      end
    end

    def authenticate_token?
      authenticate_with_http_token do |token, options|
        token == Rails.application.secrets.api_secret_token
      end
    end
  end
end
