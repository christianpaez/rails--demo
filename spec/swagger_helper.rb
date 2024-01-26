# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  default_host = ENV['RAILS_HOST'] || 'localhost:3000'

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
              default: default_host
            }
          }
        },
        {
          url: "https://{defaultHost}",
          variables: {
            defaultHost: {
              default: default_host
            }
          }
        }
      ]
    }
  }

  config.openapi_format = :yaml
end
