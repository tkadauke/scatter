module Scatter
  class Remote
    attr_reader :name, :nodes
    
    def initialize(name)
      @name = name
      @nodes = []
    end
    
    def push(gemfile)
      @nodes.each do |node|
        node.push(gemfile)
      end
    end
    
    def find_node(name)
      nodes.find { |node| node.name == name }
    end
    
    def self.decode_from_config(name, config)
      remote = new(name)
      nodes = config['nodes'].collect { |nodename, config| Node.decode_from_config(remote, nodename, config) } rescue []
      remote.nodes.concat(nodes)
      remote
    end
    
    def encode_for_config
      {
        'nodes' => @nodes.inject({}) { |hash, node| hash[node.name] = node.encode_for_config; hash }
      }
    end
  end
end
