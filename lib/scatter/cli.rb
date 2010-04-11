module Scatter
  class CLI
    def initialize(out)
      @out = out
    end
    
    def run!(args)
      raise CommandLineError, 'No command given' if args.empty?
    
      case command_name = args.shift
      when /^-?-?h(elp)?$/
        if args.empty?
          usage
        else
          if args.first == 'commands'
            commands_help
          else
            @out.puts command_class(args.first).help
          end
        end
      when /^-?-?v(ersion)?$/
        @out.puts "scatter version 0.0.1"
      else
        klass = command_class(command_name)
        command = klass.new(@out, *args)
        command.execute!
      end
    end
    
    def run(args)
      run!(args)
    rescue CommandLineError => e
      @out.puts "Error: #{e.message}"
      usage
    end
  
  protected
    def usage
      @out.puts "Usage: scatter command [options ...]"
      @out.puts "For information about the commands use: scatter help commands"
    end
    
    def commands_help
      hash = Scatter::Command.command_classes.inject({}) do |hash, cmd|
        next hash if cmd.abstract
        command_name = cmd.name.split('::').last.downcase
        hash[command_name] = cmd.short_help
        hash
      end
      
      hash.sort.each do |command, help|
        @out.puts "#{command} - #{help}"
      end
    end
  
    def command_class(command_name)
      eval("Scatter::Commands::#{command_name.capitalize}")
    rescue
      raise CommandLineError, "Unknown command #{command_name}"
    end
  end
end
