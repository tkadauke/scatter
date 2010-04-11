require File.dirname(__FILE__) + '/../../../test_helper'

class Scatter::Commands::Remote::RmTest < Test::Unit::TestCase
  def test_should_remove_remote
    rm = Scatter::Commands::Remote::Rm.new('some_remote')
    Scatter::Config.expects(:find_remote).returns(stub)
    
    Scatter::Config.expects(:remotes).returns(mock(:delete))
    Scatter::Config.expects(:save!)
    
    rm.execute!
  end
  
  def test_should_raise_exception_if_remote_does_not_exist
    rm = Scatter::Commands::Remote::Rm.new('some_remote')
    Scatter::Config.expects(:find_remote).returns(nil)
    
    assert_raise Scatter::CommandLineError do
      rm.execute!
    end
  end
end
