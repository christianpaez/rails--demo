# frozen_string_literal: true
class TickersController < ApplicationController
  def index
    begin
      tickers = TickerService.fetch_tickers(params[:key])
      if tickers["results"].nil?
        render json: { message: "No results for that key!"}  
      else
        ticker_summary = TickerSummaryService.new(tickers["results"]).to_h
        render json: ticker_summary
      end
  rescue StandardError => error
    render json: { message: error.message  }, status: :unprocessable_entity
    end
  end

    private

  def tickers_params
    params.require(:ticker).permit!(:key)
  end
end
