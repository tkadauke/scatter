module Scatter
  class Command
    class << self
      attr_reader :short_help, :help
      attr_reader :command_classes
      attr_accessor :abstract
      
      def usage(short_help, long_help = nil)
        @short_help, @help = short_help, long_help || short_help
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
