require File.dirname(__FILE__) + '/../test_helper'

class Scatter::Commands::RemoteTest < Test::Unit::TestCase
  def teardown
    FileUtils.rm_f File.dirname(__FILE__) + '/../tmp/config'
  end
  
  def test_should_list_remotes
    config_file File.dirname(__FILE__) + '/fixtures/remotes.yml'

    scatter "remote list"
    assert @out.string =~ /remote1/
    assert @out.string =~ /remote2/
    assert @out.string =~ /remote3/
  end
  
  def test_should_add_remote
    config_file File.dirname(__FILE__) + '/../tmp/config'
    
    scatter "remote add some_remote"
    Scatter::Config.reload
    assert Scatter::Config.find_remote('some_remote')
  end
  
  def test_should_rm_remote
    config_file File.dirname(__FILE__) + '/../tmp/config'
    Scatter::Config.remotes << Scatter::Remote.new('some_remote')
    Scatter::Config.save!
    Scatter::Config.reload
    
    assert Scatter::Config.find_remote('some_remote')
    
    scatter "remote rm some_remote"
    
    assert ! Scatter::Config.find_remote('some_remote')
  end
end
