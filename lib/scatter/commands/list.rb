module Scatter
  module Commands
    class List < Scatter::Command
      usage "List all gems installed on node"
      
      def initialize(node_name)
        @node_name = node_name
      end
      
      def execute!
        node.list
      end
      
      def node
        @node ||= Scatter::Config.find_node(@node_name)
      end
    end
  end
end
