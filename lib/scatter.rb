require 'yaml'

require File.dirname(__FILE__) + '/scatter/cli'
require File.dirname(__FILE__) + '/scatter/command'
require File.dirname(__FILE__) + '/scatter/super_command'
require File.dirname(__FILE__) + '/scatter/sub_command'
require File.dirname(__FILE__) + '/scatter/commands/list'
require File.dirname(__FILE__) + '/scatter/commands/push'
require File.dirname(__FILE__) + '/scatter/commands/receive'
require File.dirname(__FILE__) + '/scatter/commands/remote'
require File.dirname(__FILE__) + '/scatter/commands/remote/add'
require File.dirname(__FILE__) + '/scatter/commands/remote/list'
require File.dirname(__FILE__) + '/scatter/commands/remote/rm'
require File.dirname(__FILE__) + '/scatter/commands/node'
require File.dirname(__FILE__) + '/scatter/commands/node/add'
require File.dirname(__FILE__) + '/scatter/commands/node/list'
require File.dirname(__FILE__) + '/scatter/commands/node/rm'
require File.dirname(__FILE__) + '/scatter/commands/init'
require File.dirname(__FILE__) + '/scatter/config'
require File.dirname(__FILE__) + '/scatter/logger'
require File.dirname(__FILE__) + '/scatter/node'
require File.dirname(__FILE__) + '/scatter/remote'
require File.dirname(__FILE__) + '/scatter/gemlist'
require File.dirname(__FILE__) + '/scatter/shell'
require File.dirname(__FILE__) + '/scatter/version'

module Scatter
  class CommandLineError< StandardError; end
end
