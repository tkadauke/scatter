require File.dirname(__FILE__) + '/../../../test_helper'

class Scatter::Commands::Node::ListTest < Test::Unit::TestCase
  def test_should_list_all_nodes
    list = Scatter::Commands::Node::List.new
    Scatter::Config.expects(:nodes).returns([])
    list.execute!
  end
  
  def test_should_list_nodes_from_remote
    list = Scatter::Commands::Node::List.new('some_remote')
    Scatter::Config.expects(:find_remote).with('some_remote').returns(mock(:nodes => []))
    list.execute!
  end
  
  def test_should_output_node_names
    list = Scatter::Commands::Node::List.new
    Scatter::Config.stubs(:nodes).returns([mock(:name => 'some_node', :remote => mock(:name => 'some_remote'))])
    list.expects(:puts)
    list.execute!
  end
end