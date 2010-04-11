require File.dirname(__FILE__) + '/../../../test_helper'

class Scatter::Commands::Node::RmTest < Test::Unit::TestCase
  def test_should_remove_node_with_two_arguments
    rm = Scatter::Commands::Node::Rm.new(stub, 'some_remote', 'some_node')
    
    node = stub(:remote => stub(:nodes => mock(:delete)))
    
    Scatter::Config.expects(:find_remote).with('some_remote').returns(mock(:find_node => node))
    Scatter::Config.expects(:save!)
    
    rm.execute!
  end
  
  def test_should_remove_node_with_one_argument
    rm = Scatter::Commands::Node::Rm.new(stub, 'some_remote/some_node')
    
    node = stub(:remote => stub(:nodes => mock(:delete)))
    
    Scatter::Config.expects(:find_destination).with('some_remote/some_node').returns(node)
    Scatter::Config.expects(:save!)
    
    rm.execute!
  end
  
  def test_should_raise_exception_if_remote_doesnt_exist
    rm = Scatter::Commands::Node::Rm.new(stub, 'some_remote', 'some_node')
    
    Scatter::Config.expects(:find_remote).with('some_remote').returns(nil)
    
    assert_raise Scatter::CommandLineError do
      rm.execute!
    end
  end
  
  def test_should_raise_exception_if_node_doesnt_exist
    rm = Scatter::Commands::Node::Rm.new(stub, 'some_remote', 'some_node')
    
    Scatter::Config.expects(:find_remote).with('some_remote').returns(mock(:find_node => nil))
    
    assert_raise Scatter::CommandLineError do
      rm.execute!
    end
  end
end
