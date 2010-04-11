require File.dirname(__FILE__) + '/../../test_helper'

class Scatter::Commands::ListTest < Test::Unit::TestCase
  def test_should_list
    node = mock(:list)
    Scatter::Config.stubs(:find_node).with('some_node').returns(node)
    Scatter::Commands::List.new('some_node').execute!
  end
end
