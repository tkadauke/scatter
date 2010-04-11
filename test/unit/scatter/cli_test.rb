require File.dirname(__FILE__) + '/../test_helper'

class Scatter::CLITest < Test::Unit::TestCase
  def setup
    @out = StringIO.new
  end
  
  def test_should_raise_exception_if_no_command_given
    assert_raise Scatter::CommandLineError do
      Scatter::CLI.new(@out).run!([])
    end
  end
  
  def test_should_output_usage_on_help
    Scatter::CLI.new(@out).run!(["--help"])
    assert @out.string =~ /Usage/
  end
  
  def test_should_output_commands
    Scatter::CLI.new(@out).run!(["help", "commands"])
    assert @out.string =~ /init/
    assert @out.string =~ /list/
  end
  
  def test_should_not_output_abstract_commands
    Scatter::CLI.new(@out).run!(["help", "commands"])
    assert @out.string !~ /supercommand/
  end
  
  def test_should_output_help_for_command
    Scatter::CLI.new(@out).run!(["help", "list"])
    assert @out.string =~ /List all gems/
  end
  
  def test_should_output_version
    Scatter::CLI.new(@out).run!(["--version"])
    assert @out.string =~ /scatter version/
  end
  
  def test_should_execute_command
    Scatter::Commands::Init.any_instance.expects(:execute!)
    Scatter::CLI.new(@out).run!(["init"])
  end
  
  def test_should_raise_exception_if_command_is_unknown
    assert_raise Scatter::CommandLineError do
      Scatter::CLI.new(@out).run!(["foo"])
    end
  end
  
  def test_should_catch_command_line_exceptions
    assert_nothing_raised do
      Scatter::CLI.new(@out).run(["foo"])
    end
  end
  
  def test_should_output_error_message
    Scatter::CLI.new(@out).run(["foo"])
    assert @out.string =~ /Error/
  end
end
