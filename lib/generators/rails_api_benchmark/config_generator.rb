module RailsApiBenchmark
  module Generators
    # rails g kaminari:config
    class ConfigGenerator < Rails::Generators::Base # :nodoc:
      source_root File.expand_path(
        File.join(
          File.dirname(__FILE__),
          'templates'
        )
      )

      desc <<-DESC.strip_heredoc
        Description:
          Copies RailsApiBenchmark configuration to your app initializers folder
        DESC
      def copy_config_file
        template 'rails_api_benchmark_config.rb',
                 'config/initializers/rails_api_benchmark_config.rb'
      end
    end
  end
end
