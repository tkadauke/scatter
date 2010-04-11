require File.dirname(__FILE__) + '/../abstract_unit'
require 'shellwords'

module FunctionalTestHelper
  def scatter(string)
    @out = StringIO.new
    @cli = Scatter::CLI.new(@out)
    @cli.run!(Shellwords.shellwords(string))
  end
  
  def config_file(file_name)
    Scatter::Config.clear
    Scatter::Config.file_name = file_name
  end
end

class Test::Unit::TestCase
  include FunctionalTestHelper
end
