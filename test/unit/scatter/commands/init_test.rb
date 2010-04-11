require File.dirname(__FILE__) + '/../../test_helper'

class Scatter::Commands::InitTest < Test::Unit::TestCase
  def test_should_init_scatter
    FileUtils.expects(:mkdir_p)
    Scatter::Config.expects(:save!)
    Scatter::Commands::Init.new.execute!
  end
end
