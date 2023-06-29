require "test_helper"

class NoaWeatherStationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @noa_weather_station = noa_weather_stations(:one)
  end

  test "should get index" do
    get noa_weather_stations_url
    assert_response :success
  end

  test "should get new" do
    get new_noa_weather_station_url
    assert_response :success
  end

  test "should create noa_weather_station" do
    assert_difference("NoaWeatherStation.count") do
      post noa_weather_stations_url, params: { noa_weather_station: {  } }
    end

    assert_redirected_to noa_weather_station_url(NoaWeatherStation.last)
  end

  test "should show noa_weather_station" do
    get noa_weather_station_url(@noa_weather_station)
    assert_response :success
  end

  test "should get edit" do
    get edit_noa_weather_station_url(@noa_weather_station)
    assert_response :success
  end

  test "should update noa_weather_station" do
    patch noa_weather_station_url(@noa_weather_station), params: { noa_weather_station: {  } }
    assert_redirected_to noa_weather_station_url(@noa_weather_station)
  end

  test "should destroy noa_weather_station" do
    assert_difference("NoaWeatherStation.count", -1) do
      delete noa_weather_station_url(@noa_weather_station)
    end

    assert_redirected_to noa_weather_stations_url
  end
end
