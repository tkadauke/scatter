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
        Scatter::Config.save!
      end
    end
  end
end
