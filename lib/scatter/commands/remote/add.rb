module Scatter
  module Commands
    class Remote
      class Add < Scatter::SubCommand
        def initialize(out, name)
          super(out)
          @name = name
        end
        
        def execute!
          raise CommandLineError, "Remote #{@name} already exists" if Scatter::Config.find_remote(@name)
          Scatter::Config.remotes << Scatter::Remote.new(@name)
          Scatter::Config.save!
        end
      end
    end
  end
end
