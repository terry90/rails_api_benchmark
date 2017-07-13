require 'mustache'

module RailsApiBenchmark
  module Views
    class ResultsMarkdown < View
      attr_reader :title, :results, :target

      def initialize(target, results)
        super
        @file_name = 'results'
        @target = target
        @results = results
      end

      # Maybe put this in a superclass like MarkdownView to DRY
      def extension
        'md'
      end

      def folder
        @target.name
      end
    end
  end
end
