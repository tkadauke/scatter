module Scatter
  class Config
    def self.remotes
      load!
      @remotes ||= @config['remotes'].collect { |name, config| Remote.decode_from_config(name, config) }
    end
    
    def self.nodes
      @nodes ||= remotes.collect { |remote| remote.nodes }.flatten
    end
    
    def self.load!
      @loaded ||= begin
        @config = YAML.load(File.read("#{ENV['HOME']}/.scatter/config"))
        true
      end
    end
    
    def self.find_remote(name)
      remotes.find { |remote| remote.name == name }
    end
    
    def self.find_node(name)
      nodes.find { |node| node.name == name }
    end
    
    def self.find_destination(name)
      (remotes + nodes).find { |dest| dest.name == name }
    end
  end
end
