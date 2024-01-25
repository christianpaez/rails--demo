# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'health', type: :request do
  path '/health' do
    get('check health') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
