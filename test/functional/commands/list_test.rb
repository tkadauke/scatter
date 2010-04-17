require File.dirname(__FILE__) + '/../test_helper'

class Scatter::Commands::ListTest < Test::Unit::TestCase
  def setup
    config_file File.dirname(__FILE__) + '/fixtures/nodes.yml'
  end
  
  def teardown
    Scatter::Shell.clear_log
  end
  
  def test_should_list_gems_on_node
    scatter "list node1"
    assert_equal "ssh me@some_host gem list", Scatter::Shell.command_log.first
  end
  
  def test_should_list_gems_on_fully_qualified_node
    scatter "list remote/node2"
    assert_equal "ssh me@some_host2 gem list", Scatter::Shell.command_log.first
  end
end
