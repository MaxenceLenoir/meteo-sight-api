class SearchesController < ApplicationController
  def create
    if search_params[:city]
      weather_data = WeatherService.new.by_city(city: search_params[:city])
      render json: weather_data.to_json
    elsif search_params[:lat] && search_params[:lon]
      weather_data = WeatherService.new.by_coordinates(lat: search_params[:lat], lon: search_params[:lon])
      render json: weather_data.to_json
    else
      head :no_content
    end
  end

  private

  def search_params
    params.require(:search).permit(:id, :city, :lat, :lon)
  end
end