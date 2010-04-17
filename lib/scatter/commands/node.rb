module Scatter
  module Commands
    class Node < Scatter::SuperCommand
      usage "List, add or remove nodes", <<-end
        List, add or remove nodes from remote.
        To list nodes use the following syntax:
        
          scatter node list <remote_name>
        
        To add a node to a remote, use
        
          scatter node add <remote_name> <node_name> <username>@<hostname>
        
        To remove a node, use either of
        
          scatter node rm <node_name>
          scatter node rm <remote_name>/<node_name>
          scatter node rm <remote_name> <node_name>
      end
    end
  end
end
