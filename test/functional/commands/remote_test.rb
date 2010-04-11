require File.dirname(__FILE__) + '/../test_helper'

class Scatter::Commands::RemoteTest < Test::Unit::TestCase
  def setup
    @file_name = File.dirname(__FILE__) + '/fixtures/remotes.yml'
    config_file @file_name
  end
  
  def test_should_list_remotes
    scatter "remote list"
    assert @out.string =~ /remote1/
    assert @out.string =~ /remote2/
    assert @out.string =~ /remote3/
  end
end
