# frozen_string_literal: true
require 'rails_helper'

def random_ticker_key
  "ABCD"
end

def valid_ticker_key
  "AAPL"
end

RSpec.describe "Tickers", type: :request do
  path '/tickers' do
    get 'Retrieves tickers' do
      produces 'application/json'

      parameter name: :key, in: :query, type: :string, description: 'Ticker key'

      response '200', 'returns an empty JSON array when using random key' do
        let(:key) { random_ticker_key }

        run_test! do
          expect(JSON.parse(response.body)['resultsCount']).to eq(0)
        end
      end

      response '200', 'returns a JSON array with 250 items' do
        let(:key) { valid_ticker_key }

        run_test! do
          expect(JSON.parse(response.body)['resultsCount']).to eq(250)
        end
      end

      response '422', 'returns a 422 status' do
        before do
          allow(TickerService).to receive(:fetch_tickers).and_raise("Some API error")
        end

        let(:key) { "" }

        run_test! do
          expect(JSON.parse(response.body)["message"]).to eq("Some API error")
        end
      end
    end
  end
end
