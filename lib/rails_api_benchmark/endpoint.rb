# frozen_string_literal: true

module RailsApiBenchmark
  class Endpoint
    include Logging

    attr_reader :name, :route, :method, :title

    def initialize(opts)
      @name = opts[:name]
      @route = opts[:route]
      @method = opts[:method]
      @title = opts[:title]
      @response = nil
      @results = []
      @results_folder = "#{RailsApiBenchmark.config.results_folder}/#{@name}"
    end

    def benchmark
      benchmark_cmd = RailsApiBenchmark.config.bench_cmd
      opts = RailsApiBenchmark.config.all.merge(route: @route)

      output = `#{benchmark_cmd % opts}`

      regexps = RailsApiBenchmark.config.regexps
      regexps.each { |r| @results << output.scan(r[:regexp]) }
    end

    def query
      curl_cmd = RailsApiBenchmark.config.curl_cmd
      opts = RailsApiBenchmark.config.all.merge(route: @route)

      @response = `#{curl_cmd % opts}`
    end

    private

    def write_results
      FileUtils.mkdir_p(@results_folder)
      if @response
        File.open(File.join(@results_folder, 'response.json'), 'w+') do |f|
          f.write(@response)
        end
      end
      unless @results.empty?
        File.open(File.join(@results_folder, 'response.json'), 'w+') do |f|
          f.write(@response)
        end
      end
    end
  end
end
