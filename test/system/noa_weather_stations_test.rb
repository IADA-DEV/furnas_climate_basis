require "application_system_test_case"

class NoaWeatherStationsTest < ApplicationSystemTestCase
  setup do
    @noa_weather_station = noa_weather_stations(:one)
  end

  test "visiting the index" do
    visit noa_weather_stations_url
    assert_selector "h1", text: "Noa weather stations"
  end

  test "should create noa weather station" do
    visit noa_weather_stations_url
    click_on "New noa weather station"

    click_on "Create Noa weather station"

    assert_text "Noa weather station was successfully created"
    click_on "Back"
  end

  test "should update Noa weather station" do
    visit noa_weather_station_url(@noa_weather_station)
    click_on "Edit this noa weather station", match: :first

    click_on "Update Noa weather station"

    assert_text "Noa weather station was successfully updated"
    click_on "Back"
  end

  test "should destroy Noa weather station" do
    visit noa_weather_station_url(@noa_weather_station)
    click_on "Destroy this noa weather station", match: :first

    assert_text "Noa weather station was successfully destroyed"
  end
end
