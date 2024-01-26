# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  p "HERE"
  p ENV['RAILS_HOST']
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: "http://{defaultHost}",
          variables: {
            defaultHost: {
              default: ENV['RAILS_HOST'] || 'localhost:3000'
            }
          }
        },
        {
          url: "https://{defaultHost}",
          variables: {
            defaultHost: {
              default: ENV['RAILS_HOST'] || 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  config.openapi_format = :yaml
end
