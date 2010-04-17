require File.dirname(__FILE__) + '/../test_helper'

class Scatter::Commands::InitTest < Test::Unit::TestCase
  def setup
    @file_name = File.dirname(__FILE__) + '/../tmp/config'
    config_file @file_name, :create => false
  end
  
  def teardown
    FileUtils.rm_f @file_name
  end
  
  def test_should_create_config_file
    assert !File.exists?(@file_name)
    scatter "init"
    assert File.exists?(@file_name)
  end
  
  def test_should_be_yaml_hash
    scatter "init"
    assert YAML.load(File.read(@file_name)).is_a?(Hash)
  end
  
  def test_should_fail_when_scatter_is_not_initialized
    assert_raise Scatter::CommandLineError do
      scatter "remote list"
    end
  end
end
