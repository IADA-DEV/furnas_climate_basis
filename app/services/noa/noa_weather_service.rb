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


    # ------- restrição de request  ------- 

    # Restrição: 10 requests por minuto Noa::NoaWeatherService.noa_request_limit_reached?
    def self.noa_request_limit_reached?
        cache_key = 'noa_request_limit'

        request_count = Rails.cache.fetch(cache_key, expires_in: 1.minute) { 0 }
        
        if request_count >= 10
            return false
        else
            Rails.cache.write(cache_key, request_count+1, expires_in: expires_in(cache_key))
            return true
        end
    end

    # Restrição: 5000 requests por dia
    def self.noa_daily_request_limit_reached?
        cache_key = 'noa_request_limit_day'

        request_count = Rails.cache.fetch(cache_key, expires_in: minutes_until_midnight.minute) { 0 }
        
        if request_count >= 5000
            return false
        else
            Rails.cache.write(cache_key, request_count+1, expires_in: expires_in(cache_key))
            return true
        end
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

    def self.expires_in(cache_key)
        entry = Rails.cache.send(:read_entry, cache_key)
        return nil unless entry
      
        expires_at = entry.expires_at
        return nil unless expires_at
      
        Time.at(expires_at) - Time.current
    end

    def self.minutes_until_midnight
        current_time = Time.current
        end_of_day = current_time.end_of_day
      
        minutes_left = (end_of_day - current_time) / 60
        minutes_left.to_i
    end

  end