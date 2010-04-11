require File.dirname(__FILE__) + '/test_helper'

class Scatter::CLITest < Test::Unit::TestCase
  def test_should_raise_on_unknown_command
    assert_raise Scatter::CommandLineError do
      scatter "foo"
    end
  end
  
  def test_should_show_usage
    scatter "-h"
    assert @out.string =~ /Usage/
    scatter "-help"
    assert @out.string =~ /Usage/
    scatter "--help"
    assert @out.string =~ /Usage/
    scatter "--h"
    assert @out.string =~ /Usage/
    scatter "help"
    assert @out.string =~ /Usage/
  end
  
  def test_should_show_version
    scatter "-v"
    assert @out.string =~ /version/
    scatter "--v"
    assert @out.string =~ /version/
    scatter "-version"
    assert @out.string =~ /version/
    scatter "--version"
    assert @out.string =~ /version/
    scatter "version"
    assert @out.string =~ /version/
  end
  
  def test_should_show_commands
    scatter "help commands"
    assert @out.string =~ /init/
    scatter "--help commands"
    assert @out.string =~ /init/
  end
  
  def test_should_show_command_help
    scatter "help init"
    assert @out.string =~ /Initialize/
  end
end
