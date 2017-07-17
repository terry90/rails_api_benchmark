# frozen_string_literal: true

module RailsApiBenchmark
  class Core
    include Logging

    def self.run
      new.run
    end

    def initialize
      @config = RailsApiBenchmark.config
      @resultset = ResultSet.new
      init_files
      write_index
    end

    def run
      @config.routes.each do |route|
        e = Endpoint.new(route)
        res = e.run_benchmark
        @resultset.add(e, res)
      end
      @resultset.compute_relative_speed
      write_results
    end

    private

    def write_results
      Views::SummaryMarkdown.new(@resultset).write if @config.summary

      @resultset.each_result do |endpoint, results|
        Renderer.new(endpoint, results).process
      end
    end

    def init_files
      FileUtils.mkdir_p(@config.results_folder)
    end

    def write_index
      Views::IndexMarkdown.new.write
    end
  end
end
