module Scatter
  class SuperCommand < Command
    self.abstract = true
    
    # needed?
    class << self
      def inherited(sub)
        Command.inherited(sub)
      end
    end
    
    def initialize(out, *args)
      super(out)
      @subcmd = args.shift
      @arguments = args
    end
    
    def execute!
      subcmd_class = eval("#{self.class.name}::#{@subcmd.capitalize}")
      cmd = subcmd_class.new(@out, *@arguments)
      cmd.execute!
    rescue ArgumentError
      raise CommandLineError, "Wrong number of mandatory arguments for command #{self.class.command_name} #{@subcmd}"
    rescue NameError
      raise CommandLineError, "Unknown subcommand #{@subcmd} for command #{self.class.command_name}"
    end
  end
end
