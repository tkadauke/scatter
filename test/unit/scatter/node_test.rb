require File.dirname(__FILE__) + '/../test_helper'

class Scatter::NodeTest < Test::Unit::TestCase
  def test_should_create_node
    remote = stub
    node = Scatter::Node.new(remote, 'some_node', 'some_user', 'some_host')
    assert_equal remote, node.remote
    assert_equal 'some_node', node.name
    assert_equal 'some_user', node.username
    assert_equal 'some_host', node.hostname
  end
  
  def test_should_list_gems
    node = Scatter::Node.new(stub, 'some_node', 'some_user', 'some_host')
    node.expects(:system).with(regexp_matches(/gem list/))
    node.list
  end
  
  def test_should_push_gem
    node = Scatter::Node.new(stub, 'some_node', 'some_user', 'some_host')
    node.expects(:system).with(regexp_matches(/scp/))
    node.expects(:system).with(regexp_matches(/gem install/))
    node.expects(:system).with(regexp_matches(/scatter receive/))
    node.push('gemfile')
  end
  
  def test_should_decode_node_from_config
    remote = stub
    node = Scatter::Node.decode_from_config(remote, 'some_node', { 'username' => 'some_user', 'hostname' => 'some_host' })
    assert_equal remote, node.remote
    assert_equal 'some_node', node.name
    assert_equal 'some_user', node.username
    assert_equal 'some_host', node.hostname
  end
  
  def test_should_encode_node_for_config
    node = Scatter::Node.new(stub, 'some_node', 'some_user', 'some_host')
    assert_equal({"username"=>"some_user", "hostname"=>"some_host"}, node.encode_for_config)
  end
end
