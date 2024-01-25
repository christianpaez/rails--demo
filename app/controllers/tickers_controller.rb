# frozen_string_literal: true
class TickersController < ApplicationController
  def index
    begin
      tickers = TickerService.fetch_tickers(params[:key])
      render json: tickers
  rescue StandardError => error
    render json: { message: error.message  }, status: :unprocessable_entity
    end
  end

    private

  def tickers_params
    params.require(:ticker).permit!(:key)
  end
end
