module Scatter
  module Commands
    class Receive
      def initialize(gemfile)
        @gemfile = gemfile
      end
      
      def execute!
        if File.executable?("#{ENV['HOME']}/.scatter/post-receive")
          Scatter::Logger.log("Executing post receive hook")
          system "#{ENV['HOME']}/.scatter/post-receive #{@gemfile}"
        end
      end
    end
  end
end
