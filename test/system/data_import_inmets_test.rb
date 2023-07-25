require "application_system_test_case"

class DataImportInmetsTest < ApplicationSystemTestCase
  setup do
    @data_import_inmet = data_import_inmets(:one)
  end

  test "visiting the index" do
    visit data_import_inmets_url
    assert_selector "h1", text: "Data import inmets"
  end

  test "should create data import inmet" do
    visit data_import_inmets_url
    click_on "New data import inmet"

    fill_in "Dta fim", with: @data_import_inmet.dta_fim
    fill_in "Dta inicio", with: @data_import_inmet.dta_inicio
    fill_in "Inmet weather station", with: @data_import_inmet.inmet_weather_station_id
    check "Status" if @data_import_inmet.status
    click_on "Create Data import inmet"

    assert_text "Data import inmet was successfully created"
    click_on "Back"
  end

  test "should update Data import inmet" do
    visit data_import_inmet_url(@data_import_inmet)
    click_on "Edit this data import inmet", match: :first

    fill_in "Dta fim", with: @data_import_inmet.dta_fim
    fill_in "Dta inicio", with: @data_import_inmet.dta_inicio
    fill_in "Inmet weather station", with: @data_import_inmet.inmet_weather_station_id
    check "Status" if @data_import_inmet.status
    click_on "Update Data import inmet"

    assert_text "Data import inmet was successfully updated"
    click_on "Back"
  end

  test "should destroy Data import inmet" do
    visit data_import_inmet_url(@data_import_inmet)
    click_on "Destroy this data import inmet", match: :first

    assert_text "Data import inmet was successfully destroyed"
  end
end
