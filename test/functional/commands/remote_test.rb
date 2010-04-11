require File.dirname(__FILE__) + '/../test_helper'

class Scatter::Commands::RemoteTest < Test::Unit::TestCase
  def setup
    @file_name = File.dirname(__FILE__) + '/fixtures/remotes.yml'
    config_file @file_name
  end
  
  def test_should_list_remotes
    # TODO: use StringIO in commands
    # scatter "remote list"
  end
end
