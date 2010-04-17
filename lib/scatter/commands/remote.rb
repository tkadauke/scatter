module Scatter
  module Commands
    class Remote < Scatter::SuperCommand
      usage "List, add or remove remotes", <<-end
        List, add or remove remotes.
        To list remotes use the following syntax:
        
          scatter remote list
        
        To add a remote, use
        
          scatter remote add <remote_name>
        
        To remove a remote, use
        
          scatter remote rm <remote_name>
      end
    end
  end
end
