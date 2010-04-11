require File.dirname(__FILE__) + '/../../../test_helper'

class Scatter::Commands::Remote::ListTest < Test::Unit::TestCase
  def test_should_list_all_remotes
    list = Scatter::Commands::Remote::List.new(stub(:puts))
    Scatter::Config.expects(:remotes).returns([stub(:name => 'some_remote')])
    list.execute!
  end
end
