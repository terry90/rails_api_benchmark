require 'mustache'

module RailsApiBenchmark
  module Views
    class ResultsMarkdown < View
      attr_reader :title, :req_per_sec, :response_time

      def initialize(target, results)
        super
        @title = target.title
        @req_per_sec = results[:req_per_sec] || 'Unknown'
        @response_time = results[:response_time] || 'Unknown'
      end

      # Maybe put this in a superclass like MarkdownView to DRY
      def extension
        'md'
      end

      def file_name
        'results'
      end

      def folder
        @target.name
      end
    end
  end
end
