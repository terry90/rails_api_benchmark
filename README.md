# RailsApiBenchmark

Work in progress, you can use it like this, see [Important](#important)

## Usage

Run it with:
```bash
rails api:benchmark
```

Display your configuration with:
```bash
rails api:benchmark:config
```

Example output:

```json
{
  "concurrency": 2,
  "host": "localhost:5000",
  "nb_requests": 1000,
  "results_folder": "benchmark",
  "auth_header": "Authorization: Token token=benchToken",
  "curl_cmd": "curl -H \"%{auth_header}\" http://%{host}%{route}",
  "bench_cmd": "ab -n %{nb_requests} -c %{concurrency} -g plot.tsv -H \"%{auth_header}\" http://%{host}%{route}",
  "server_cmd": "bundle exec puma",
  "env_vars": {
    "RAILS_MAX_THREADS": "2",
    "RAILS_ENV": "production"
  },
  "regexps": [
    {
      "key": "response_time",
      "name": "Average time per request (ms)",
      "regexp": "(?-mix:Time\\s+per\\s+request:\\s+([0-9.]*).*\\(mean\\))"
    },
    {
      "key": "req_per_sec",
      "name": "Requests per second (#)",
      "regexp": "(?-mix:Requests\\s+per\\s+second:\\s+([0-9.]*).*\\(mean\\))"
    }
  ],
  "routes": [
    {
      "name": "candidates_per_25",
      "route": "/candidates",
      "method": "get",
      "title": "GET /candidates",
      "description": "Get first page of candidates (default 25 per page)"
    }
  ]
}

```


## Important

* Only JSON responses are supported yet
* Only GET requests are supported yet
* Configuration is not validated

## Installation

* Install gnuplot
* Install ApacheBench

For ubuntu:
```bash
sudo apt-get install gnuplot
sudo apt-get install apache2-utils
```
* Add this line to your application's Gemfile:

```ruby
gem 'rails_api_benchmark'
```

* And then execute:
```bash
bundle
```

* Provide necessary configuration in initializer, generate it with:

```bash
rails g rails_api_benchmark:config
```

* Next, add this to your Rakefile:

```ruby
require 'rails_api_benchmark/benchmark_tasks'
```

You can now run:

```bash
rails api:benchmark
```

## Screenshots

### The README is the benchmark index, the page you’ll see in benchmark/ folder. It lists all the routes configured to be benchmarked:
![Benchmark Index](http://imgur.com/S05CSs3.png)

### Results are listed in a summary table to allow fast-spotting of slowdowns:
![Benchmark Summary](http://imgur.com/le1ULaB.png)

### Result page for a single route with gnuplot:
![Benchmark Results](http://imgur.com/z3RcSwO.png)

## Contributing
Contributions are welcome

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

### TODO
* POST requests handling
* Add simplecov to permit controller coverage for example
* Document configuration template file
