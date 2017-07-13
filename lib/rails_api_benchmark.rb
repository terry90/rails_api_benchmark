require 'rails_api_benchmark/logging'
require 'rails_api_benchmark/server'
require 'rails_api_benchmark/core'
require 'rails_api_benchmark/renderer'
require 'rails_api_benchmark/graph'
require 'rails_api_benchmark/subprocess'
require 'rails_api_benchmark/endpoint'
require 'rails_api_benchmark/views/view' # Requires all the views

module RailsApiBenchmark
  class Config
    attr_accessor :concurrency, :nb_requests, :auth_header,
                  :server_cmd, :bench_cmd, :curl_cmd, :results_folder,
                  :regexps, :env_vars, :routes, :host
    def all
      instance_variables.inject({}) do |h, v|
        var = v.to_s.sub('@', '')
        h.merge(var.to_sym => send(var))
      end
    end
  end

  class << self
    attr_writer :config

    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end
  end
end
