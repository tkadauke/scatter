module Scatter
  module Commands
    class Node
      class List
        def initialize(name = nil)
          @name = name
        end
        
        def execute!
          nodes = if @name
            Scatter::Config.find_remote(@name).nodes
          else
            Scatter::Config.nodes
          end

          nodes.each do |node|
            puts "#{node.remote.name}/#{node.name}"
          end
        end
      end
    end
  end
end
