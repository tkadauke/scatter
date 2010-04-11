require File.dirname(__FILE__) + '/../../../test_helper'

class Scatter::Commands::Node::AddTest < Test::Unit::TestCase
  def test_should_add_node
    add = Scatter::Commands::Node::Add.new(stub, 'some_remote', 'some_node', 'some_user@some_user')
    remote = stub(:find_node => nil, :nodes => [])
    Scatter::Config.stubs(:find_remote).returns(remote)
    Scatter::Config.expects(:save!)
    add.execute!
    
    assert_equal 1, remote.nodes.size
    assert_equal 'some_node', remote.nodes.last.name
  end
  
  def test_should_raise_exception_if_remote_does_not_exist
    add = Scatter::Commands::Node::Add.new(stub, 'some_remote', 'some_node', 'some_user@some_user')
    Scatter::Config.stubs(:find_remote).returns(nil)
    
    assert_raise Scatter::CommandLineError do
      add.execute!
    end
  end
  
  def test_should_raise_exception_if_node_already_exists
    add = Scatter::Commands::Node::Add.new(stub, 'some_remote', 'some_node', 'some_user@some_user')
    remote = stub(:find_node => stub)
    Scatter::Config.stubs(:find_remote).returns(remote)
    
    assert_raise Scatter::CommandLineError do
      add.execute!
    end
  end
end
