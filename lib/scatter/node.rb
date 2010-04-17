module Scatter
  class Node
    attr_reader :remote, :name, :username, :hostname
    
    def initialize(remote, name, username, hostname)
      @remote, @name, @username, @hostname = remote, name, username, hostname
    end
    
    def full_name
      [remote.name, name].join('/')
    end
    
    def list
      Scatter::Gemlist.parse(Scatter::Shell.capture("ssh #{@username}@#{@hostname} gem list"))
    end
    
    def push(gemfile)
      Scatter::Shell.execute "scp #{gemfile} #{@username}@#{@hostname}:/tmp"
      Scatter::Shell.execute "ssh #{@username}@#{@hostname} sudo gem install /tmp/#{File.basename(gemfile)}"
      Scatter::Shell.execute "ssh #{@username}@#{@hostname} scatter receive /tmp/#{File.basename(gemfile)}"
    end
    
    def self.decode_from_config(remote, name, config)
      new(remote, name, config['username'], config['hostname'])
    end
    
    def encode_for_config
      {
        'username' => @username,
        'hostname' => @hostname
      }
    end
  end
end
