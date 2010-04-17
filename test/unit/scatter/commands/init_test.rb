require File.dirname(__FILE__) + '/../../test_helper'

class Scatter::Commands::InitTest < Test::Unit::TestCase
  def test_should_init_scatter
    FileUtils.expects(:mkdir_p)
    File.stubs(:exists?).returns(false)
    file_mock = mock(:puts)
    File.expects(:open).yields(file_mock)
    Scatter::Commands::Init.new(stub).execute!
  end
  
  def test_should_not_overwrite_existing_config
    FileUtils.expects(:mkdir_p)
    File.stubs(:exists?).returns(true)
    File.expects(:open).never
    Scatter::Commands::Init.new(stub).execute!
  end
end
