module Scatter
  module Commands
    class List < Scatter::Command
      usage "List all gems installed on node"
      
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
