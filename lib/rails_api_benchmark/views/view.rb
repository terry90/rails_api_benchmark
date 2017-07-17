require 'erubis'

module RailsApiBenchmark
  module Views
    class View
      def initialize(*_args)
        @config = RailsApiBenchmark.config
        @template_path = File.expand_path('../../templates', __FILE__)
      end

      # Override this method in your view
      def file_name
        "#{@file_name}.#{extension}"
      end

      # Override this method in your view
      def folder
        nil
      end

      def file_path
        [folder, file_name].compact.join('/')
      end

      def write
        File.open(File.join(@config.results_folder, file_path), 'w') do |file|
          file << render
        end
      end

      def render
        template = File.read(File.join(@template_path, "#{template_name}.erb"))
        Erubis::Eruby.new(template).result(binding)
      end

      private

      def template_name # Avoid module
        self.class.name
            .split('::').last
            .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .tr('-', '_')
            .downcase
      end
    end
  end
end

require_relative 'results_markdown'
require_relative 'summary_markdown'
require_relative 'index_markdown'
