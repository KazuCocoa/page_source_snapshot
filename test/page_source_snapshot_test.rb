require 'test_helper'

class PageSourceSnapshotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PageSourceSnapshot::VERSION
  end

  def test_true_case
    e = File.read('./test/data/test_hidekeyboard-failed.xml')
    a = File.read('./test/data/test_hidekeyboard-failed.xml')
    assert PageSourceSnapshot.new(e, a)
  end

  def test_false_case
    result = PageSourceSnapshot.new(File.read('./test/data/test_hidekeyboard-failed.xml'), File.read('./test/data/test_push_file-failed.xml'))
    assert !result.compare
    assert_equal result.error_message, ""
  end
end
