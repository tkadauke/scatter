module Scatter
  module Commands
    class Push < Scatter::Command
      usage "Push gem to remote or node"
      
      def initialize(out, gemfile, destination)
        super(out)
        @gemfile, @destination = gemfile, destination
      end
      
      def execute!
        dest.push(@gemfile)
      end
      
      def dest
        @dest ||= Scatter::Config.find_destination(@destination)
      end
    end
  end
end
