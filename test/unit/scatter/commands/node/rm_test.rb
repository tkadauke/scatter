require File.dirname(__FILE__) + '/../../../test_helper'

class Scatter::Commands::Node::RmTest < Test::Unit::TestCase
  def test_should_remove_node_with_two_arguments
    list = Scatter::Commands::Node::Rm.new('some_remote', 'some_node')
    
    node = stub(:remote => stub(:nodes => mock(:delete)))
    
    Scatter::Config.expects(:find_remote).with('some_remote').returns(mock(:find_node => node))
    Scatter::Config.expects(:save!)
    
    list.execute!
  end
  
  def test_should_remove_node_with_one_argument
    list = Scatter::Commands::Node::Rm.new('some_remote/some_node')
    
    node = stub(:remote => stub(:nodes => mock(:delete)))
    
    Scatter::Config.expects(:find_destination).with('some_remote/some_node').returns(node)
    Scatter::Config.expects(:save!)
    
    list.execute!
  end
end
