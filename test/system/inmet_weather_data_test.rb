require "application_system_test_case"

class InmetWeatherDataTest < ApplicationSystemTestCase
  setup do
    @inmet_weather_datum = inmet_weather_data(:one)
  end

  test "visiting the index" do
    visit inmet_weather_data_url
    assert_selector "h1", text: "Inmet weather data"
  end

  test "should create inmet weather datum" do
    visit inmet_weather_data_url
    click_on "New inmet weather datum"

    click_on "Create Inmet weather datum"

    assert_text "Inmet weather datum was successfully created"
    click_on "Back"
  end

  test "should update Inmet weather datum" do
    visit inmet_weather_datum_url(@inmet_weather_datum)
    click_on "Edit this inmet weather datum", match: :first

    click_on "Update Inmet weather datum"

    assert_text "Inmet weather datum was successfully updated"
    click_on "Back"
  end

  test "should destroy Inmet weather datum" do
    visit inmet_weather_datum_url(@inmet_weather_datum)
    click_on "Destroy this inmet weather datum", match: :first

    assert_text "Inmet weather datum was successfully destroyed"
  end
end
