require 'mustache'

module RailsApiBenchmark
  module Views
    class View < Mustache
      def initialize(*_args)
        @template_path = File.expand_path('../../templates', __FILE__)
      end

      def file_name
        "#{@file_name}.#{extension}"
      end

      def file_path
        [folder, file_name].compact.join('/')
      end

      def folder
        nil
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
require_relative 'index_markdown'
