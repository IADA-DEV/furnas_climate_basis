class Inmet::InmetWeatherService

    def self.stations() 
      return api_call(URL_STATION_INMET, { 'token' => TOKEN_INMET })
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