# frozen_string_literal: true

module RailsApiBenchmark
  class Core
    include Logging

    def self.run
      new.run
    end

    def initialize
      @config = RailsApiBenchmark.config
    end

    def run
      init_files
      @config.routes.each do |route|
        e = Endpoint.new(route)
        res = e.run_benchmark
        write_results(e, res)
      end
      create_index
    end

    def write_results(endpoint, results)
      Renderer.new(endpoint, results).process
    end

    def init_files
      FileUtils.mkdir_p(@config.results_folder)
    end

    def create_index
      view = Views::IndexMarkdown.new(@config.routes)
      File.open(File.join(@config.results_folder, view.file_name), 'w') do |file|
        file << view.render
      end
    end
  end
end
