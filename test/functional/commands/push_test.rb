require File.dirname(__FILE__) + '/../test_helper'

class Scatter::Commands::PushTest < Test::Unit::TestCase
  def setup
    config_file File.dirname(__FILE__) + '/fixtures/nodes.yml'
  end
  
  def teardown
    Scatter::Shell.clear_log
  end
  
  def test_should_push_gem_to_node
    scatter "push mygem.gem node1"
    assert_equal "scp mygem.gem me@some_host:/tmp", Scatter::Shell.command_log.first
  end
  
  def test_should_push_gem_to_fully_qualified_node
    scatter "push mygem.gem remote/node2"
    assert_equal "scp mygem.gem me@some_host2:/tmp", Scatter::Shell.command_log.first
  end
  
  def test_should_push_gem_to_remote
    scatter "push mygem.gem another_remote"
    assert_equal "scp mygem.gem me@some_host4:/tmp", Scatter::Shell.command_log.first
  end
end
