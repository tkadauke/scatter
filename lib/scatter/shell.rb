module Scatter
  module Shell
    extend self
    
    attr_accessor :dry_run
    attr_accessor :command_log
    
    def execute(command)
      log_command command
      system command unless dry_run
    end
    
    def capture(command)
      log_command command
      %x{#{command}} unless dry_run
    end
    
    def clear_log
      self.command_log = []
    end
    
  protected
    def log_command(command)
      self.command_log ||= []
      self.command_log << command
    end
  end
end
