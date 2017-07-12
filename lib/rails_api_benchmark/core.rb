# frozen_string_literal: true

module RailsApiBenchmark
  class Core
    include Logging

    class << self
      def run
        logger.info 'Begin benchmark...'
        RailsApiBenchmark.config.routes.each do |route|
          puts route[:name]
          Endpoint.new(route).benchmark
          Endpoint.new(route).query
        end
        logger.info 'DONE!'
      end
    end
  end
end
