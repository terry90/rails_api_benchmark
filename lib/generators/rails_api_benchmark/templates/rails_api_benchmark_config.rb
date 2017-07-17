# unless Rails.env.production?
RailsApiBenchmark.configure do |config|
  # config.concurrency = 2
  # config.host = 'localhost:5000'
  # config.nb_requests = 1000
  # config.results_folder = 'benchmark'
  # config.auth_header = 'Authorization: Token token=benchToken'
  # Use only if you want to log the responses
  # config.curl_cmd = 'curl -H "%{auth_header}" http://%{host}%{route}'
  # Keep plot.tsv to render graph
  # config.bench_cmd = 'ab -n %{nb_requests} -c %{concurrency} -g plot.tsv' \
  #  ' -H "%{auth_header}" http://%{host}%{route}'
  # config.server_cmd = 'bundle exec puma'
  # config.env_vars = {
  # 'RAILS_MAX_THREADS' => '2',
  # 'SECRET_KEY_BASE' => 'bench',
  # 'RAILS_ENV' => 'production',
  # 'PORT' => '5000'
  # }
  # config.regexps = [
  #   {
  #     key: :response_time,
  #     name: 'Average time per request (ms)',
  #     regexp: /Time\s+per\s+request:\s+([0-9.]*).*\(mean\)/
  #   }, {
  #     key: :req_per_sec,
  #     name: 'Requests per second (#)',
  #     regexp: /Requests\s+per\s+second:\s+([0-9.]*).*\(mean\)/
  #   }
  # ]
  config.routes = [
    {
      name: 'todo_list',
      route: '/todos',
      method: :get,
      title: 'GET /todos',
      description: 'Get first page of todos (default 25 per page)'
    }
  ].freeze
end
# end
