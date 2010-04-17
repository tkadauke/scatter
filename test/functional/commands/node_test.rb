require File.dirname(__FILE__) + '/../test_helper'

class Scatter::Commands::NodeTest < Test::Unit::TestCase
  def teardown
    FileUtils.rm_f File.dirname(__FILE__) + '/../tmp/config'
  end
  
  def test_should_list_all_nodes
    config_file File.dirname(__FILE__) + '/fixtures/nodes.yml'

    scatter "node list"
    assert @out.string =~ /remote\/node1/
    assert @out.string =~ /remote\/node2/
    assert @out.string =~ /remote\/node3/
  end
  
  def test_should_list_nodes_from_single_remote
    config_file File.dirname(__FILE__) + '/fixtures/nodes.yml'

    scatter "node list another_remote"

    assert @out.string =~ /another_remote\/node4/

    assert @out.string !~ /remote\/node1/
    assert @out.string !~ /remote\/node2/
    assert @out.string !~ /remote\/node3/
  end
  
  def test_should_add_node
    config_file File.dirname(__FILE__) + '/../tmp/config'
    
    Scatter::Config.remotes << Scatter::Remote.new('some_remote')
    Scatter::Config.save!
    Scatter::Config.reload

    assert ! Scatter::Config.find_node('some_node')

    scatter "node add some_remote some_node username@hostname"

    Scatter::Config.reload
    assert Scatter::Config.find_node('some_node')
  end
  
  def test_should_rm_node
    config_file File.dirname(__FILE__) + '/../tmp/config'
    remote = Scatter::Remote.new('some_remote')
    node = Scatter::Node.new(remote, 'some_node', 'username', 'hostname')
    remote.nodes << node
    Scatter::Config.remotes << remote
    Scatter::Config.save!
    Scatter::Config.reload
    
    assert Scatter::Config.find_node('some_node')
    
    scatter "node rm some_node"
    
    Scatter::Config.reload
    assert ! Scatter::Config.find_node('some_node')
  end
end
