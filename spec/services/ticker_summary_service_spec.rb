# frozen_string_literal: true

require_relative '../../app/services/ticker_summary_service.rb'

describe TickerSummaryService do
  subject(:ticker_summary_service) { TickerSummaryService.new(api_response["results"]) }

  let(:api_response) do
    {
      "results" => [
        { "o" => 100.0, "c" => 110.0, "h" => 120.0, "l" => 90.0, "vw" => 105.0 },
        { "o" => 150.0, "c" => 160.0, "h" => 170.0, "l" => 140.0, "vw" => 155.0 },
        { "o" => 120.0, "c" => 130.0, "h" => 140.0, "l" => 110.0, "vw" => 125.0 }
      ]
    }
  end

  describe '#to_h' do
    it 'returns a hash with the average opening and closing prices rounded to two decimal places' do
      expected_result = {
      "price" => { "average" => 128.33, "high" => 143.33, "low" => 113.33 },
      "volume" => { "average" => 128.33, "high" => 155.0, "low" => 105.0 }
    }
      expect(ticker_summary_service.to_h).to eq(expected_result)
    end
  end
end
