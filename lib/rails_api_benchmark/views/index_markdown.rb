require 'mustache'

module RailsApiBenchmark
  module Views
    class IndexMarkdown < View
      attr_reader :routes, :nb_routes, :config

      def initialize
        super
        @file_name = 'README'
        @routes = @config.routes
        @nb_routes = routes.count
      end

      # Maybe put this in a superclass like MarkdownView to DRY
      def extension
        'md'
      end
    end
  end
end
