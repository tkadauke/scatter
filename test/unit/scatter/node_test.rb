require File.dirname(__FILE__) + '/../test_helper'

class Scatter::NodeTest < Test::Unit::TestCase
  def setup
    Scatter::Shell.clear_log
  end
  
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
    Scatter::Shell.expects(:capture).with(regexp_matches(/gem list/))
    node.list
  end
  
  def test_should_push_gem
    node = Scatter::Node.new(stub, 'some_node', 'some_user', 'some_host')
    node.push('gemfile')
    [/scp/, /gem install/, /scatter receive/].each_with_index do |rx, i|
      assert Scatter::Shell.command_log[i] =~ rx
    end
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
  
  def test_should_figure_out_full_name
    node = Scatter::Node.new(stub(:name => 'some_remote'), 'some_node', 'some_user', 'some_host')
    assert_equal 'some_remote/some_node', node.full_name
  end
end
