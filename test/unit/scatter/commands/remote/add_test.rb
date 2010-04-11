require File.dirname(__FILE__) + '/../../../test_helper'

class Scatter::Commands::Remote::AddTest < Test::Unit::TestCase
  def test_should_add_remote
    add = Scatter::Commands::Remote::Add.new('some_remote')
    Scatter::Config.expects(:find_remote).returns(nil)
    Scatter::Config.expects(:save!)
    add.execute!
    
    assert_equal 'some_remote', Scatter::Config.remotes.last.name
  end
  
  def test_should_raise_exception_if_remote_already_exists
    add = Scatter::Commands::Remote::Add.new('some_remote')
    Scatter::Config.expects(:find_remote).returns(stub)
    
    assert_raise Scatter::CommandLineError do
      add.execute!
    end
  end
end
