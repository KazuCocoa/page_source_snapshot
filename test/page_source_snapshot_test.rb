require 'test_helper'

class PageSourceSnapshotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PageSourceSnapshot::VERSION
  end

  def test_true
    e = File.read('./test/data/test_hidekeyboard-failed.xml')
    a = File.read('./test/data/test_hidekeyboard-failed.xml')
    assert PageSourceSnapshot.new(e, a)
  end

  def test_false
    e = File.read('./test/data/test_hidekeyboard-failed.xml')
    a = File.read('./test/data/test_push_file-failed.xml')
    result = PageSourceSnapshot.new(e, a)
    assert !result.compare
    assert result.error_message != ""
  end

  def test_pass_because_all_elements_are_ignored
    e = File.read('./test/data/test_hidekeyboard-failed.xml')
    a = File.read('./test/data/test_push_file-failed.xml')

    result = PageSourceSnapshot.new(e, a, ["visible", "width", "height", "x", "y", "name", "label", "type", "value"])
    assert result.compare
    assert_equal result.error_message, ""
  end

  def test_false_error_message
    e = "<a enabled=\"true\" visible=\"true\" x=\"20\">"
    a = "<a enabled=\"true\" visible=\"false\" x=\"0\">"
    result = PageSourceSnapshot.new(e, a)
    assert !result.compare
    assert_equal "{\"visible\"=>\"expect: true, actual: false\", \"x\"=>\"expect: 20, actual: 0\"}\n", result.error_message
  end
end
