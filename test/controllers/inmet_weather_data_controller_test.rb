require "test_helper"

class InmetWeatherDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inmet_weather_datum = inmet_weather_data(:one)
  end

  test "should get index" do
    get inmet_weather_data_url
    assert_response :success
  end

  test "should get new" do
    get new_inmet_weather_datum_url
    assert_response :success
  end

  test "should create inmet_weather_datum" do
    assert_difference("InmetWeatherDatum.count") do
      post inmet_weather_data_url, params: { inmet_weather_datum: {  } }
    end

    assert_redirected_to inmet_weather_datum_url(InmetWeatherDatum.last)
  end

  test "should show inmet_weather_datum" do
    get inmet_weather_datum_url(@inmet_weather_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_inmet_weather_datum_url(@inmet_weather_datum)
    assert_response :success
  end

  test "should update inmet_weather_datum" do
    patch inmet_weather_datum_url(@inmet_weather_datum), params: { inmet_weather_datum: {  } }
    assert_redirected_to inmet_weather_datum_url(@inmet_weather_datum)
  end

  test "should destroy inmet_weather_datum" do
    assert_difference("InmetWeatherDatum.count", -1) do
      delete inmet_weather_datum_url(@inmet_weather_datum)
    end

    assert_redirected_to inmet_weather_data_url
  end
end
