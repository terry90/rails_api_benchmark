# frozen_string_literal: true

require 'open3'

module RailsApiBenchmark
  class Subprocess
    def self.kill_all
      # Tried things, didn't work. This kills evrything
      Process.kill('INT', -Process.getpgrp)
    end

    def initialize(cmd, env)
      Process.spawn(env, cmd)
    end
  end
end
