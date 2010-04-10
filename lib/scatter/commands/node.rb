module Scatter
  module Commands
    class Node
      def initialize(*args)
        @args = args
      end
      
      def execute!
        subcmd = @args.shift
        send(subcmd) if ['list', 'add', 'rm'].include?(subcmd)
      end
      
      def list
        name = @args.first
        nodes = if name
          Scatter::Config.find_remote(name).nodes
        else
          Scatter::Config.nodes
        end
        
        nodes.each do |node|
          puts "#{node.remote.name}/#{node.name}"
        end
      end
      
      def add
        raise "Not enough arguments" unless @args.size == 3
        remote_name, node, credentials = *@args
        remote = Scatter::Config.find_remote(remote_name)
        raise "Unknown remote #{remote_name}" unless remote
        remote.nodes << Scatter::Node.new(remote, node, *(credentials.split('@')))
        Scatter::Config.save!
      end
      
      def rm
        raise "Not enough arguments" if @args.size < 1
        node = if @args.size == 2
          remote, node = *@args
          Scatter::Config.find_remote(remote).find_node(node)
        else
          Scatter::Config.find_destination(@args.first)
        end
        
        node.remote.nodes.delete(node)
        Scatter::Config.save!
      end
    end
  end
end
