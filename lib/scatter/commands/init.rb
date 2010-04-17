require 'fileutils'

module Scatter
  module Commands
    class Init < Scatter::Command
      usage "Initialize scatter configuration", <<-end
        Initializes your machine to use scatter. You need to run this command only once.
        However, it should not break anything if you run it again.
      end
      
      def execute!
        FileUtils.mkdir_p File.dirname(Scatter::Config.file_name)
        unless File.exists?(Scatter::Config.file_name)
          File.open(Scatter::Config.file_name, 'w') { |file| file.puts({}.to_yaml) }
        end
      end
    end
  end
end
