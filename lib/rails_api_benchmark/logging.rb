module RailsApiBenchmark
  module Logging
    class << self
      def logger
        @logger ||= Logger.new(STDOUT)
      end

      attr_writer :logger
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
