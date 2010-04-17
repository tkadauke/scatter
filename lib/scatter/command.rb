module Scatter
  class Command
    def initialize(out)
      @out = out
    end
    
    class << self
      attr_reader :short_help
      attr_reader :command_classes
      attr_accessor :abstract
      
      def usage(short_help, long_help = nil)
        @short_help, @help = short_help, long_help || short_help
      end
      
      def help
        lines = @help.split("\n")
        indent = lines.collect { |l| l[/^(\s*)/, 1].size }.min
        lines.collect { |l| l[indent..-1] }.join("\n")
      end
      
      def inherited(sub)
        (@command_classes ||= []) << sub
      end
      
      def command_name
        name.split('::').last.downcase
      end
    end
  end
end
