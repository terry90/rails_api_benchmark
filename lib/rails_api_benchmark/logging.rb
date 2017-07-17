module RailsApiBenchmark
  module Logging
    class << self
      attr_writer :logger

      def logger
        @logger ||= Logger.new(STDOUT)
      end
    end

    def self.included(base)
      class << base
        def logger
          Logging.logger
        end
      end
    end

    def logger
      Logging.logger
    end
  end
end
