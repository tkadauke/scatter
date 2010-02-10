module Scatter
  class Node
    attr_reader :name
    
    def initialize(name, username, hostname)
      @name, @username, @hostname = name, username, hostname
    end
    
    def list
      system "ssh #{@username}@#{@hostname} gem list"
    end
    
    def push(gemfile)
      system "scp #{gemfile} #{@username}@#{@hostname}:/tmp"
      system "ssh #{@username}@#{@hostname} sudo gem install /tmp/#{File.basename(gemfile)}"
      system "ssh #{@username}@#{@hostname} scatter receive /tmp/#{File.basename(gemfile)}"
    end
    
    def self.decode_from_config(name, config)
      new(name, config['username'], config['hostname'])
    end
    
    def self.encode_for_config
      {
        @name => {
          'username' => @username,
          'hostname' => @hostname
        }
      }
    end
  end
end
