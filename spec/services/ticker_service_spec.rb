require 'rails_helper'

def api_successful_response 
    {
      "ticker": "AAPL",
      "queryCount": 250,
      "resultsCount": 3,
      "adjusted": true,
      "results": [
        {
          "v": 1.12117471e+08,
          "vw": 125.725,
          "o": 130.28,
          "c": 125.07,
          "h": 130.9,
          "l": 124.17,
          "t": 1672722000000,
          "n": 1021065
        },
        {
          "v": 8.9100633e+07,
          "vw": 126.6464,
          "o": 126.89,
          "c": 126.36,
          "h": 128.6557,
          "l": 125.08,
          "t": 1672808400000,
          "n": 770042
        },
        {
          "v": 8.0716808e+07,
          "vw": 126.0883,
          "o": 127.13,
          "c": 125.02,
          "h": 127.77,
          "l": 124.76,
          "t": 1672894800000,
          "n": 665458
        }
      ]
    }  
end

def api_empty_response 
    {
      "ticker": "AAPL",
      "queryCount": 0,
      "resultsCount": 0,
      "adjusted": true,
      "results": [
      ]
    }  
end

def ticker_key 
  "ABCD"
end

RSpec.describe TickerService, type: :service do
  describe "fetch_tickers" do
    context "when the external API returns 0 results" do
      it "returns an empty array" do
        response = double(body:api_empty_response.to_json)
        allow(Net::HTTP).to receive(:get_response).and_return(response)
        tickers = TickerService.fetch_tickers(ticker_key)

        expect(tickers["results"].size).to eq(0)
      end
    end

    context "when the external API returns 3 results" do
      it "returns an array with 3 items" do
        response = double(body:api_successful_response.to_json)
        allow(Net::HTTP).to receive(:get_response).and_return(response)
        tickers = TickerService.fetch_tickers(ticker_key)

        expect(tickers["results"].size).to eq(3)
      end
    end

    context "when the external API returns a non-success status" do
      it "raises an ExternalApiError" do
        response = 'Not available'
        allow(Net::HTTP).to receive(:get_response).and_raise(response)

        expect {
          TickerService.fetch_tickers(ticker_key)
        }.to raise_error("External API error: Not available")
      end
    end

    context "when there is a network error with the external API" do
      it "raises an ExternalApiError" do
        allow(Net::HTTP).to receive(:get_response).and_raise(StandardError.new("Network error"))

        expect {
          TickerService.fetch_tickers(ticker_key)
        }.to raise_error("External API error: Network error")
      end
    end
  end
end
