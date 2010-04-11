require File.dirname(__FILE__) + '/../test_helper'

class Scatter::RemoteTest < Test::Unit::TestCase
  def test_should_store_name
    remote = Scatter::Remote.new('some_remote')
    assert_equal 'some_remote', remote.name
  end
  
  def test_should_initialize_nodes_array
    remote = Scatter::Remote.new('some_remote')
    assert_equal [], remote.nodes
  end
  
  def test_should_push_to_all_nodes
    remote = Scatter::Remote.new('some_remote')
    remote.nodes << mock(:push) << mock(:push)
    remote.push('gemfile')
  end
  
  def test_should_find_node
    node = stub(:name => 'some_node')
    remote = Scatter::Remote.new('some_remote')
    remote.nodes << stub(:name) << node << stub(:name)
    assert_equal node, remote.find_node('some_node')
  end
  
  def test_should_decode_from_config
    remote = Scatter::Remote.decode_from_config('some_remote', { 'nodes' => { 'some_node' => { 'username' => 'some_user', 'hostname' => 'some_host' } } })
    assert_equal 'some_remote', remote.name
    assert_equal 'some_user', remote.nodes.first.username
    assert_equal 'some_host', remote.nodes.first.hostname
  end
  
  def test_should_decode_from_nil_config
    assert_nothing_raised do
      remote = Scatter::Remote.decode_from_config('some_remote', nil)
      assert_equal [], remote.nodes
    end
  end

  def test_should_decode_from_config_without_nodes
    assert_nothing_raised do
      remote = Scatter::Remote.decode_from_config('some_remote', { 'nodes' => nil })
      assert_equal [], remote.nodes
    end
  end
  
  def test_should_encode_for_config_without_nodes
    remote = Scatter::Remote.new('some_remote')
    assert_equal({"nodes"=>{}}, remote.encode_for_config)
  end
  
  def test_should_encode_for_config_with_nodes
    remote = Scatter::Remote.new('some_remote')
    remote.nodes << stub(:name => 'some_node', :encode_for_config => 'node_content')
    assert_equal({"nodes"=>{"some_node"=>"node_content"}}, remote.encode_for_config)
  end
end
