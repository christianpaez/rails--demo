class TickerService
    def self.fetch_tickers(ticker_key)
      api_url = "https://api.polygon.io/v2/aggs/ticker/#{ticker_key}/range/1/day/2023-01-01/2023-12-31?apiKey=taIMgMrmnZ8SUZmdpq9_7ANRDxw3IPIx"
      
      begin
        uri = URI(api_url)
        response = Net::HTTP.get_response(uri)
        handle_response(response)
      rescue StandardError => e
        handle_api_error(e)
      end
    end
  
    private
  
    def self.handle_response(response)
      JSON.parse(response.body)
    end
  
    def self.handle_api_error(error)
      Rails.logger.error("External API error: #{error}")
      raise "External API error: #{error.message}"
    end
  end
  