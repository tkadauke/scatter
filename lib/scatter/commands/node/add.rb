module Scatter
  module Commands
    class Node
      class Add < Scatter::SubCommand
        def initialize(out, remote_name, node, credentials)
          super(out)
          @remote_name, @node, @credentials = remote_name, node, credentials
        end
        
        def execute!
          remote = Scatter::Config.find_remote(@remote_name)
          raise CommandLineError, "Unknown remote #{@remote_name}" unless remote
          raise CommandLineError, "Remote #{@remote_name} already has node #{@node}" if remote.find_node(@node)
          remote.nodes << Scatter::Node.new(remote, @node, *(@credentials.split('@')))
          Scatter::Config.save!
        end
      end
    end
  end
end
