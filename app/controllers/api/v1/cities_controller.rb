require 'httparty'
require 'json'

class Api::V1::CitiesController < ApplicationController
  before_action :validate_params, only: [:weather]

  def weather
    begin
      request = HTTParty.get(ENV.fetch("RESERVAMOS_API"), query: {'q': params[:q] })

      if request.code != 201
        render json: { error: request.body }, status: request.code
        return
      else
        cities = JSON.parse(request.body)
        weather_cities = []

        cities.each do |city|
          if ENV.fetch("ONLY_MEXICO_CITIES") == 'true'
            if city["country"] == 'México'
              weather_url = "#{ENV.fetch("WEATHER_API")}?lat=#{city['lat']}&lon=#{city['long']}&units=metric&appid=#{ENV.fetch("WEATHER_API_KEY")}"
              weather_request = HTTParty.get(weather_url)

              if weather_request.code == 200
                weather_city = []
                weather_forecast = JSON.parse(weather_request.body)
                weather_forecast_daily = weather_forecast['list'].select { |item| item['dt_txt'].include?('09:00:00') }
                weather_forecast_daily.each do |weather_forecast_day|
                  weather_city << {
                    "day": weather_forecast_day['dt_txt'],
                    "min": "#{weather_forecast_day['main']['temp_min']}°C",
                    "max": "#{weather_forecast_day['main']['temp_max']}°C"
                  }
                end
                weather_cities << {
                  "city": city['display'],
                  "country": city['country'],
                  "weathers": weather_city
                }
              end
            end
          else
            weather_url = "#{ENV.fetch("WEATHER_API")}?lat=#{city['lat']}&lon=#{city['long']}&units=metric&appid=#{ENV.fetch("WEATHER_API_KEY")}"
            weather_request = HTTParty.get(weather_url)

            if weather_request.code == 200
              weather_city = []
              weather_forecast = JSON.parse(weather_request.body)
              weather_forecast_daily = weather_forecast['list'].select { |item| item['dt_txt'].include?('09:00:00') }
              weather_forecast_daily.each do |weather_forecast_day|
                weather_city << {
                  "day": weather_forecast_day['dt_txt'],
                  "min": "#{weather_forecast_day['main']['temp_min']}°C",
                  "max": "#{weather_forecast_day['main']['temp_max']}°C"
                }
              end
              weather_cities << {
                "city": city['display'],
                "country": city['country'],
                "weathers": weather_city
              }
            end
          end
        end
        render json: {"data": weather_cities}, status: 201
      end
    rescue StandardError => e
      puts e.message
      render json: { error: "Internal Server Error" }, status: :internal_server_error
      return
    end
  end

  private
  def validate_params
    param_cities = params[:q]

    if param_cities.nil? || param_cities.empty?
      render json: { error: "El parámetro 'q' no está presente o está vacío" }, status: :bad_request
    end
  end
end
