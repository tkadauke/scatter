module Scatter
  module Commands
    class Receive < Scatter::Command
      usage "Inform scatter that gem was received; calls post receive hook"
      
      def initialize(gemfile)
        @gemfile = gemfile
      end
      
      def execute!
        if File.executable?("#{ENV['HOME']}/.scatter/post-receive")
          Scatter::Logger.log("Executing post receive hook")
          Scatter::Shell.execute "#{ENV['HOME']}/.scatter/post-receive #{@gemfile}"
        end
      end
    end
  end
end
