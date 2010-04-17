require File.dirname(__FILE__) + '/../test_helper'

class Scatter::ConfigTest < Test::Unit::TestCase
  def setup
    Scatter::Config.clear
  end
  
  def test_should_clear_config_instance
    old_instance = Scatter::Config.instance
    assert_equal old_instance, Scatter::Config.instance
    Scatter::Config.clear
    assert_not_equal old_instance, Scatter::Config.instance
  end
  
  def test_should_reload_config_and_keep_config_file_name
    Scatter::Config.instance.file_name = 'test'
    old_instance = Scatter::Config.instance
    Scatter::Config.reload
    assert_not_equal old_instance, Scatter::Config.instance
    assert_equal old_instance.file_name, Scatter::Config.file_name
  end
  
  def test_should_direct_method_calls_to_instance
    Scatter::Config.instance.expects(:foo)
    Scatter::Config.foo
  end
  
  def test_should_raise_exception_if_instance_doesnt_respond_to_method
    assert_raise NoMethodError do
      Scatter::Config.foo
    end
  end
  
  def test_should_load_remotes_from_config
    File.stubs(:read).returns({ 'remotes' => { 'some_remote' => { 'nodes' => {} } } }.to_yaml)
    remotes = Scatter::Config.remotes
    assert_equal 1, remotes.size
    assert_equal 'some_remote', remotes.first.name
  end
  
  def test_should_load_nodes_from_config
    File.stubs(:read).returns({ 'remotes' => { 'some_remote' => { 'nodes' => { 'some_node' => { 'user_name' => 'me', 'host' => 'some_host' } } } } }.to_yaml)
    nodes = Scatter::Config.nodes
    assert_equal 1, nodes.size
    assert_equal 'some_node', nodes.first.name
  end
  
  def test_should_find_remotes
    remote = stub(:name => 'some_remote')
    Scatter::Config.instance.expects(:remotes).returns([remote])
    assert_equal remote, Scatter::Config.find_remote('some_remote')
  end
  
  def test_should_find_node
    node = stub(:name => 'some_node')
    Scatter::Config.instance.expects(:nodes).returns([node])
    assert_equal node, Scatter::Config.find_node('some_node')
  end
  
  def test_should_find_node_by_full_name
    node = stub(:name => 'some_node', :full_name => 'some_remote/some_node')
    Scatter::Config.instance.expects(:nodes).returns([node])
    assert_equal node, Scatter::Config.find_node('some_remote/some_node')
  end
  
  def test_should_find_destination_by_remote_name
    remote = stub(:name => 'some_remote')
    Scatter::Config.instance.expects(:remotes).returns([remote])
    Scatter::Config.instance.expects(:nodes).returns([])
    assert_equal remote, Scatter::Config.find_destination('some_remote')
  end
  
  def test_should_find_destination_by_node_name
    node = stub(:name => 'some_node')
    Scatter::Config.instance.expects(:remotes).returns([])
    Scatter::Config.instance.expects(:nodes).returns([node])
    assert_equal node, Scatter::Config.find_destination('some_node')
  end
  
  def test_should_find_destination_by_full_qualified_node_specifier
    remote = stub(:name => 'some_remote')
    node = stub(:name => 'some_node')
    Scatter::Config.instance.expects(:remotes).returns([remote])
    remote.expects(:find_node).returns(node)
    assert_equal node, Scatter::Config.find_destination('some_remote/some_node')
  end
  
  def test_should_return_not_raise_exception_when_search_by_full_qualified_node_specifier_and_remote_does_not_exist
    remote = nil
    Scatter::Config.instance.expects(:find_remote).returns(nil)
    assert_nil Scatter::Config.find_destination('some_remote/some_node')
  end
  
  def test_should_save_config
    remote = stub(:name => 'some_remote', :encode_for_config => { 'nodes' => { 'some_node' => { 'username' => 'some_user', 'hostname' => 'some_host' } } })
    Scatter::Config.instance.expects(:remotes).returns([remote])
    file_mock = mock
    file_mock.expects(:puts).with(regexp_matches(/some_remote/))
    File.expects(:open).yields(file_mock)
    Scatter::Config.save!
  end
end
