module Scatter
  module Commands
    class List < Scatter::Command
      usage "List all gems installed on node", <<-end
        List all gems on a node. The node can be specified by name or by fully qualified
        node name. Examples:
        
          scatter list nodename
          scatter list remote/nodename
      end
      
      def initialize(out, node_name)
        super(out)
        @node_name = node_name
      end
      
      def execute!
        gemlist = node.list
        @out.puts gemlist.gem_output
      end
      
      def node
        @node ||= Scatter::Config.find_node(@node_name)
      end
    end
  end
end
