# RailsApiBenchmark

Work in progress, yet you can use it like this.

## Usage

Run it with rake api:benchmark

## Important

* Only JSON responses are supported yet
* Only GET requests are supported yet
* Configuration is not validated

## Installation

Install gnuplot (Google)

Add this line to your application's Gemfile:

```ruby
gem 'rails_api_benchmark'
```

And then execute:
```bash
$ bundle
```

Provide necessary configuration in initializer, example config (mine):

```ruby
unless Rails.env.production?
  RailsApiBenchmark.configure do |config|
    # Try different configs. You may need to run the
    # benchmark in a production ready environment to get reliable results
    config.concurrency = 2
    config.host = 'localhost:5000' # example.com
    config.nb_requests = 3000
    config.results_folder = 'benchmark'
    config.auth_header = 'Authorization: Token token=benchToken'
    # Use only if you want to log the responses
    config.curl_cmd = 'curl -H "%{auth_header}" http://%{host}%{route}'
    # Use Apache Bench
    config.bench_cmd = 'ab -n %{nb_requests} -c %{concurrency} -g plot.tsv -e plot.csv -H "%{auth_header}" http://%{host}%{route}'
    config.server_cmd = 'bundle exec puma'
    config.env_vars = {
      'RAILS_MAX_THREADS' => '2',
      'SECRET_KEY_BASE' => 'bench',
      'RAILS_ENV' => 'production',
      'SSL_DISABLE' => 'yup',
      'PORT' => '5000'
    }
    config.regexps = [ # Used to get results from the output of benchmark tools
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
    config.routes = [
      {
        name: 'candidates_per_25',
        route: '/candidates',
        method: :get,
        title: 'GET /candidates'
      }
    ].freeze
  end
end
```

Next, add this to your Rakefile:

```ruby
require 'rails_api_benchmark/benchmark_tasks'
```

You can now run `rake api:benchmark` !

## Contributing
Contributions are welcome

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

### TODO
* Summary file (.md), to show response time for each endpoint and compare with others to track the slowest
* POST requests handling
* Create generator for config initializer
* Add simplecov to permit controller coverage for example
