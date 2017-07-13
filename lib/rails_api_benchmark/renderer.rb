module RailsApiBenchmark
  class Renderer
    attr_reader :output_dir, :target, :results

    def initialize(target, results)
      @output_dir = RailsApiBenchmark.config.results_folder
      @target = target
      @results = results
    end

    def process
      Graph.new(@target, @output_dir).generate
      generate_view
    end

    private

    def generate_view
      view = Views::ResultsMarkdown.new(target, results)
      dest = File.join(@output_dir, view.file_path)
      FileUtils.mkdir_p(File.dirname(dest))
      File.open(File.join(@output_dir, view.file_path), 'w') do |file|
        file << view.render
      end
    end
  end
end
