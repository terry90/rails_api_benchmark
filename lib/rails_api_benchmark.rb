require 'rails_api_benchmark/logging'
require 'rails_api_benchmark/server'
require 'rails_api_benchmark/core'
require 'rails_api_benchmark/renderer'
require 'rails_api_benchmark/graph'
require 'rails_api_benchmark/subprocess'
require 'rails_api_benchmark/endpoint'
require 'rails_api_benchmark/views/view' # Requires all the views

module RailsApiBenchmark
  class Configuration
    attr_accessor :concurrency, :nb_requests, :auth_header,
                  :server_cmd, :bench_cmd, :curl_cmd, :results_folder,
                  :regexps, :env_vars, :routes, :host

    # Default values, INSANE. Must be refactored
    # Maybe create a yaml or json file to import for default values
    def initialize
      self.concurrency = 2
      self.nb_requests = 1000
      self.server_cmd = 'bundle exec puma'
      self.bench_cmd = 'ab -n %{nb_requests} -c %{concurrency} -g plot.tsv' \
                  ' -H "%{auth_header}" http://%{host}%{route}'
      self.curl_cmd = 'curl -H "%{auth_header}" http://%{host}%{route}'
      self.results_folder = 'benchmark'
      self.regexps = [
        {
          key: :response_time,
          name: 'Average time per request (ms)',
          regexp: /Time\s+per\s+request:\s+([0-9.]*).*\(mean\)/
        }, {
          key: :req_per_sec,
          name: 'Requests per second (#)',
          regexp: /Requests\s+per\s+second:\s+([0-9.]*).*\(mean\)/
        }
      ]
      self.env_vars = {
        'RAILS_MAX_THREADS' => '2',
        'RAILS_ENV' => 'production',
        'SSL_DISABLE' => 'true',
        'SECRET_KEY_BASE' => '123',
        'PORT' => '5000'
      }
      self.routes = []
      self.host = 'localhost:5000'
    end

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
      @config ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end
