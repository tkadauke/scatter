module Scatter
  module Commands
    class Push
      def initialize(gemfile, destination)
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