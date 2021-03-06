module Scatter
  module Commands
    class Node
      class List < Scatter::SubCommand
        def initialize(out, name = nil)
          super(out)
          @name = name
        end
        
        def execute!
          nodes = if @name
            remote = Scatter::Config.find_remote(@name)
            raise CommandLineError, "Unknown remote #{@name}" unless remote
            remote.nodes
          else
            Scatter::Config.nodes
          end

          nodes.each do |node|
            @out.puts "#{node.remote.name}/#{node.name}"
          end
        end
      end
    end
  end
end
