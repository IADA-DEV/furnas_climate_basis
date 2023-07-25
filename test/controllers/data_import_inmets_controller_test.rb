require "test_helper"

class DataImportInmetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @data_import_inmet = data_import_inmets(:one)
  end

  test "should get index" do
    get data_import_inmets_url
    assert_response :success
  end

  test "should get new" do
    get new_data_import_inmet_url
    assert_response :success
  end

  test "should create data_import_inmet" do
    assert_difference("DataImportInmet.count") do
      post data_import_inmets_url, params: { data_import_inmet: { dta_fim: @data_import_inmet.dta_fim, dta_inicio: @data_import_inmet.dta_inicio, inmet_weather_station_id: @data_import_inmet.inmet_weather_station_id, status: @data_import_inmet.status } }
    end

    assert_redirected_to data_import_inmet_url(DataImportInmet.last)
  end

  test "should show data_import_inmet" do
    get data_import_inmet_url(@data_import_inmet)
    assert_response :success
  end

  test "should get edit" do
    get edit_data_import_inmet_url(@data_import_inmet)
    assert_response :success
  end

  test "should update data_import_inmet" do
    patch data_import_inmet_url(@data_import_inmet), params: { data_import_inmet: { dta_fim: @data_import_inmet.dta_fim, dta_inicio: @data_import_inmet.dta_inicio, inmet_weather_station_id: @data_import_inmet.inmet_weather_station_id, status: @data_import_inmet.status } }
    assert_redirected_to data_import_inmet_url(@data_import_inmet)
  end

  test "should destroy data_import_inmet" do
    assert_difference("DataImportInmet.count", -1) do
      delete data_import_inmet_url(@data_import_inmet)
    end

    assert_redirected_to data_import_inmets_url
  end
end
