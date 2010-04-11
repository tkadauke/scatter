require File.dirname(__FILE__) + '/../test_helper'

class Scatter::ShellTest < Test::Unit::TestCase
  def setup
    Scatter::Shell.clear_log
  end
  
  def test_should_log_command_when_executing
    Scatter::Shell.execute('some command')
    assert_equal 'some command', Scatter::Shell.command_log.first
  end
  
  def test_should_execute_unless_dry_run
    without_dry_run do
      Scatter::Shell.expects(:system).with('some command')
      Scatter::Shell.execute('some command')
    end
  end
  
  def test_should_log_command_when_capturing
    Scatter::Shell.capture('some command')
    assert_equal 'some command', Scatter::Shell.command_log.first
  end
  
  def test_should_capture_unless_dry_run
    without_dry_run do
      Scatter::Shell.expects(:`).with('some command').returns('result')
      assert_equal 'result', Scatter::Shell.capture('some command')
    end
  end
  
protected
  def without_dry_run(&block)
    old_dry_run = Scatter::Shell.dry_run
    Scatter::Shell.dry_run = false
    yield
  ensure
    Scatter::Shell.dry_run = old_dry_run
  end
end
