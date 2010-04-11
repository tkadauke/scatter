require File.dirname(__FILE__) + '/../../test_helper'

class Scatter::Commands::ListTest < Test::Unit::TestCase
  def test_should_list
    node = mock(:list => stub(:gem_output => 'asdf'))
    Scatter::Config.stubs(:find_node).with('some_node').returns(node)
    list = Scatter::Commands::List.new(mock(:puts), 'some_node')
    list.execute!
  end
end
