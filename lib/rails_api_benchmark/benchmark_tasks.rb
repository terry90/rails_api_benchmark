module RailsApiBenchmark
  class BenchmarkTasks
    include Rake::DSL if defined? Rake::DSL

    def install_tasks
      namespace :api do
        desc 'Runs Rails API benchmark'
        task benchmark: :environment do # Gosh, that's dirty !
          puts RailsApiBenchmark.config.all
          RailsApiBenchmark::Server.run
          sleep(3) # Leave time to boot
          RailsApiBenchmark::Core.run

          at_exit { RailsApiBenchmark::Subprocess.kill_all }
        end

        namespace :benchmark do
          desc 'Prints RailsApiBenchmark config'
          task config: :environment do
            require 'json'

            puts JSON.pretty_generate(RailsApiBenchmark.config.all)
          end
        end
      end
    end
  end
end

RailsApiBenchmark::BenchmarkTasks.new.install_tasks
