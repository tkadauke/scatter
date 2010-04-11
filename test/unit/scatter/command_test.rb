require File.dirname(__FILE__) + '/../test_helper'

class Scatter::CommandTest < Test::Unit::TestCase
  class Testcmd < Scatter::Command
    usage "Short help", "Long help"
  end
  
  def test_should_figure_out_command_name
    assert_equal 'testcmd', Testcmd.command_name
  end
  
  def test_should_return_short_help
    assert_equal "Short help", Testcmd.short_help
  end

  def test_should_return_long_help
    assert_equal "Long help", Testcmd.help
  end
  
  def test_should_keep_track_of_inherited_classes
    assert Scatter::Command.command_classes.include?(Testcmd)
  end
  
  def test_should_not_be_abstract_by_default
    assert !Testcmd.abstract
  end
end
