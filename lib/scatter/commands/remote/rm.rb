module Scatter
  module Commands
    class Remote
      class Rm < Scatter::SubCommand
        def initialize(out, name)
          super(out)
          @name = name
        end
        
        def execute!
          remote = Scatter::Config.find_remote(@name)
          raise CommandLineError, "Remote #{@name} does not exist" unless remote
          Scatter::Config.remotes.delete(remote)
          Scatter::Config.save!
        end
      end
    end
  end
end
