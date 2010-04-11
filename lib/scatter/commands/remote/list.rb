module Scatter
  module Commands
    class Remote
      class List
        def execute!
          Scatter::Config.remotes.each do |remote|
            puts remote.name
          end
        end
      end
    end
  end
end
