require File.dirname(__FILE__) + '/../../test_helper'

class Scatter::Commands::PushTest < Test::Unit::TestCase
  def test_should_push
    node = mock(:push)
    Scatter::Config.stubs(:find_destination).with('some_node').returns(node)
    Scatter::Commands::Push.new(stub, 'gemfile', 'some_node').execute!
  end
end
