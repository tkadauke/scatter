require File.dirname(__FILE__) + '/../test_helper'

class Scatter::SuperCommandTest < Test::Unit::TestCase
  class Testcmd < Scatter::SuperCommand
    usage "Short help", "Long help"
  end
  
  class Testcmd::Sub
    def initialize(a, b)
    end
    def execute!
    end
  end
  
  def test_should_be_abstract
    assert Scatter::SuperCommand.abstract
  end
  
  def test_should_be_registered_with_command_class
    assert Scatter::Command.command_classes.include?(Testcmd)
  end
  
  def test_should_filter_subcommand_name_from_arguments
    cmd = Testcmd.new('sub', 1, 2)
    assert_equal 'sub', cmd.instance_variable_get(:@subcmd)
  end
  
  def test_should_give_extra_arguments_to_subcommand
    cmd = Testcmd.new('sub', 1, 2)
    Testcmd::Sub.expects(:new).with(1, 2).returns(mock(:execute!))
    cmd.execute!
  end
  
  def test_should_not_raise_exception_on_correct_usage
    assert_nothing_raised do
      Testcmd.new('sub', 1, 2).execute!
    end
  end
  
  def test_should_raise_exception_on_unknown_subcommand
    assert_raise Scatter::CommandLineError do
      Testcmd.new('foo', 1, 2).execute!
    end
  end
  
  def test_should_raise_exception_on_incorrect_number_of_parameters
    assert_raise Scatter::CommandLineError do
      Testcmd.new('sub', 1).execute!
    end
  end
end
