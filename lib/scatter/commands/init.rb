module Scatter
  module Commands
    class Init
      def execute!
        FileUtils.mkdir_p File.dirname(Scatter::Config.file_name)
        Scatter::Config.save!
      end
    end
  end
end
