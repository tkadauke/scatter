module Scatter
  module Commands
    class Node
      class Rm
        def initialize(remote, node = nil)
          @remote, @node = remote, node
        end
        
        def execute!
          node = if @node
            Scatter::Config.find_remote(@remote).find_node(@node)
          else
            Scatter::Config.find_destination(@remote)
          end

          node.remote.nodes.delete(node)
          Scatter::Config.save!
        end
      end
    end
  end
end
