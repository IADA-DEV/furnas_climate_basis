class Inmet::InmetWeatherService

    def self.stations() 
      return api_call(URL_STATION_INMET, { 'token' => TOKEN_INMET })
    end

    # Inmet::InmetWeatherService.data('2022-11-01', '2022-11-02', 'A001' )
    def self.data(dta_start, dta_end, id_station)
      get_url = URL_DATA_INMET + '/' + dta_start + '/' + dta_end + '/' + id_station + '/' + TOKEN_INMET
      return api_call(get_url)
    end

    private

    def self.api_call(path, headers = {}, payload = {})
        begin
            response = RestClient.get(path, headers)
            return JSON.parse(response.body)
        rescue Exception => e
            # params = { path: path, headers: headers, payload: payload, response: response }
           
            # LogErro.create(
            #     model: 'Noa::NoaWeatherService'
            #     description: params,
            #     erro: e
            # )
  
          return {}
        end
    end

  end