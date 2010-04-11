module Scatter
  class Config
    class << self
      def instance
        @instance ||= new
      end
      
      def clear
        @instance = nil
      end
      
      def reload
        @instance = new(@instance.file_name)
      end
      
      def method_missing(method, *args)
        if instance.respond_to?(method)
          instance.send(method, *args)
        else
          super
        end
      end
    end
    
    attr_accessor :file_name
    
    def initialize(file_name = nil)
      self.file_name = file_name || "#{ENV['HOME']}/.scatter/config"
    end

    def remotes
      load!
      @remotes ||= (@config['remotes'] || {}).collect { |name, config| Scatter::Remote.decode_from_config(name, config) }
    end
    
    def nodes
      @nodes ||= remotes.collect { |remote| remote.nodes }.flatten
    end
    
    def load!
      @loaded ||= begin
        @config = YAML.load(File.read(file_name)) rescue {}
        true
      end
    end
    
    def save!
      config = {
        'remotes' => self.remotes.inject({}) { |hash, remote| hash[remote.name] = remote.encode_for_config; hash }
      }
      File.open(file_name, 'w') { |file| file.puts config.to_yaml }
    end
    
    def find_remote(name)
      remotes.find { |remote| remote.name == name }
    end
    
    def find_node(name)
      nodes.find { |node| node.name == name }
    end
    
    def find_destination(name)
      if name =~ /\//
        remote, node = *(name.split('/'))
        remote_object = find_remote(remote)
        remote_object.find_node(node) if remote_object
      else
        (remotes + nodes).find { |dest| dest.name == name }
      end
    end
  end
end
