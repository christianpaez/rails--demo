# frozen_string_literal: true

class HealthController < ApplicationController
  def check
    render json: { message: 'ok' }, status: :ok
  end
end