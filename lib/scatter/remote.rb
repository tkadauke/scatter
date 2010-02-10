module Scatter
  class Remote
    attr_reader :name, :nodes
    
    def initialize(name, nodes)
      @name, @nodes = name, nodes
    end
    
    def push(gemfile)
      @nodes.each do |node|
        node.push(gemfile)
      end
    end
    
    def self.decode_from_config(name, config)
      nodes = config['nodes'].collect { |nodename, config| Node.decode_from_config(nodename, config) } rescue []
      new(name, nodes)
    end
    
    def self.encode_for_config
      {
        @name => {
          'nodes' => @nodes.collect { |node| node.encode_for_config }
        }
      }
    end
  end
end
