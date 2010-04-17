require File.dirname(__FILE__) + '/../abstract_unit'
require 'shellwords'

module FunctionalTestHelper
  def scatter(string)
    @out = StringIO.new
    @cli = Scatter::CLI.new(@out)
    @cli.run!(Shellwords.shellwords(string))
  end
  
  def config_file(file_name, options = {})
    Scatter::Config.clear
    Scatter::Config.file_name = file_name
    
    unless options[:create] == false
      unless File.exists?(file_name)
        File.open(file_name, 'w') { |file| file.puts({}.to_yaml) }
      end
    end
  end
end

class Test::Unit::TestCase
  include FunctionalTestHelper
end
