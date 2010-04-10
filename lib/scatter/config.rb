module Scatter
  class Config
    def self.remotes
      load!
      @remotes ||= (@config['remotes'] || {}).collect { |name, config| Scatter::Remote.decode_from_config(name, config) }
    end
    
    def self.nodes
      @nodes ||= remotes.collect { |remote| remote.nodes }.flatten
    end
    
    def self.load!
      @loaded ||= begin
        @config = YAML.load(File.read(file_name)) rescue {}
        true
      end
    end
    
    def self.save!
      config = {
        'remotes' => self.remotes.inject({}) { |hash, remote| hash[remote.name] = remote.encode_for_config; hash }
      }
      File.open(file_name, 'w') { |file| file.puts config.to_yaml }
    end
    
    def self.find_remote(name)
      remotes.find { |remote| remote.name == name }
    end
    
    def self.find_node(name)
      nodes.find { |node| node.name == name }
    end
    
    def self.find_destination(name)
      if name =~ /\//
        remote, node = *(name.split('/'))
        find_remote(remote).find_node(node)
      else
        (remotes + nodes).find { |dest| dest.name == name }
      end
    end
    
    def self.file_name
      "#{ENV['HOME']}/.scatter/config"
    end
  end
end
