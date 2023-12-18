class Api::V1::HealthController < ApplicationController
  def index
    health_data = {
      api_version: ENV.fetch("API_VERSION") { "-" },
      enviroment: ENV.fetch("RAILS_ENV") { "-" },
      message: "I'm ok"
    }

    render json: health_data, status: 200
  end
end
