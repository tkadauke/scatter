module Scatter
  module Commands
    class Remote
      def initialize(*args)
        @args = args
      end
      
      def execute!
        subcmd = @args.shift
        send(subcmd) if ['list', 'add', 'rm'].include?(subcmd)
      end
      
      def list
        Scatter::Config.remotes.each do |remote|
          puts remote.name
        end
      end
      
      def add
        raise "Not enough arguments" unless @args.size == 1
        name = @args.first
        Scatter::Config.remotes << Scatter::Remote.new(name)
        Scatter::Config.save!
      end
      
      def rm
        raise "Not enough arguments" unless @args.size == 1
        name = @args.first
        remote = Scatter::Config.find_remote(remote)
        Scatter::Config.remotes.delete(remote)
        Scatter::Config.save!
      end
    end
  end
end
