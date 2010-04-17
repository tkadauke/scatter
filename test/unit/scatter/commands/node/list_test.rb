require File.dirname(__FILE__) + '/../../../test_helper'

class Scatter::Commands::Node::ListTest < Test::Unit::TestCase
  def test_should_list_all_nodes
    list = Scatter::Commands::Node::List.new(stub)
    Scatter::Config.expects(:nodes).returns([])
    list.execute!
  end
  
  def test_should_list_nodes_from_remote
    list = Scatter::Commands::Node::List.new(stub, 'some_remote')
    Scatter::Config.expects(:find_remote).with('some_remote').returns(mock(:nodes => []))
    list.execute!
  end
  
  def test_should_raise_exception_if_remote_does_not_exist
    list = Scatter::Commands::Node::List.new(stub, 'some_remote')
    Scatter::Config.expects(:find_remote).with('some_remote').returns(nil)
    
    assert_raise Scatter::CommandLineError do
      list.execute!
    end
  end
  
  def test_should_output_node_names
    list = Scatter::Commands::Node::List.new(mock(:puts))
    Scatter::Config.stubs(:nodes).returns([mock(:name => 'some_node', :remote => mock(:name => 'some_remote'))])
    list.execute!
  end
end
