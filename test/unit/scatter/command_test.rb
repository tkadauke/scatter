require File.dirname(__FILE__) + '/../test_helper'

class Scatter::CommandTest < Test::Unit::TestCase
  class Testcmd < Scatter::Command
    usage "Short help", <<-end
      Long help
      More help
      
      Empty line
      
        indented line
      
      normal indent again
    end
  end
  
  def test_should_figure_out_command_name
    assert_equal 'testcmd', Testcmd.command_name
  end
  
  def test_should_return_short_help
    assert_equal "Short help", Testcmd.short_help
  end

  def test_should_return_long_help
    long_help = Testcmd.help.split("\n")
    assert_equal "Long help", long_help.first
    assert_equal "", long_help[2]
    assert_equal "  indented line", long_help[5]
    assert_equal "normal indent again", long_help[7]
  end
  
  def test_should_keep_track_of_inherited_classes
    assert Scatter::Command.command_classes.include?(Testcmd)
  end
  
  def test_should_not_be_abstract_by_default
    assert !Testcmd.abstract
  end
end
