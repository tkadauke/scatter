module Scatter
  module Commands
    class Remote
      class List < Scatter::SubCommand
        def execute!
          Scatter::Config.remotes.each do |remote|
            @out.puts remote.name
          end
        end
      end
    end
  end
end
