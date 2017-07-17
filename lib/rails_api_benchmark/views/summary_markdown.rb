require 'mustache'

module RailsApiBenchmark
  module Views
    class SummaryMarkdown < View
      attr_reader :results, :avg

      def initialize(resultset)
        super
        @file_name = 'summary'
        @results = resultset.results
        @avg = resultset.averages
      end

      # Maybe put this in a superclass like MarkdownView to DRY
      def extension
        'md'
      end
    end
  end
end
