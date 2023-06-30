class Noa::NoaWeatherService

    def self.all_pages_stations
        response = api_call(URL_STATION_NOA + 'locationid=FIPS%3ABR&limit=1', { 'token' => TOKEN_NOA })
        resp_json =  response['metadata']['resultset']['count'] 
  
        return (resp_json/1000.0).ceil if resp_json.present?
    end
  
    def self.stations(page) 

      response = api_call(URL_STATION_NOA + "locationid=FIPS%3ABR&limit=1000&offset=#{page}", { 'token' => TOKEN_NOA })
  
      return response['results']
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