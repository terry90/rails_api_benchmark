# frozen_string_literal: true

module RailsApiBenchmark
  class Server
    def initialize
      @cmd = RailsApiBenchmark.config.server_cmd
      @env = RailsApiBenchmark.config.env_vars
    end

    def run
      Subprocess.new(@cmd, @env)
    end

    def self.run
      new.run
    end
  end
end
