module Scatter
  module Commands
    class Push < Scatter::Command
      usage "Push gem to remote or node", <<-end
        Pushes a gem to a remote or node. Use the remote name, node name or fully
        qualified node name to specify the target. Examples:
        
          # to push to node my_node
          scatter push my_gem.gem my_node
          scatter push my_gem.gem my_remote/my_node
          
          # to push to remote my_remote
          scatter push my_gem.gem my_remote
      end
      
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
