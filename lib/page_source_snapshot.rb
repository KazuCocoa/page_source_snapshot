require 'oga'
require 'page_source_snapshot/version'
require 'page_source_snapshot/elements'

class PageSourceSnapshot
  attr_reader :expect, :actual, :error_message

  def initialize(expect_xml, actual_xml, ignore_attributes = [])
    @expect = get_elements expect_xml, ignore_attributes
    @actual = get_elements actual_xml, ignore_attributes
    @error_message = ""
  end

  def compare
    message = ""
    @expect.zip(@actual).each do |e, a|
      if (e - a) != []
        message << error(e[1], a[1])
      end
    end

    @error_message = message
    @error_message.empty? ? true : false
  end

  def error(expect, actual)
    return if expect.nil? || actual.nil?
    return "expect: #{expect}, actual: #{actual}" unless expect.is_a?(Hash) && actual.is_a?(Hash)

    e_keys = expect.keys

    diff = {}

    e_keys.each do |key|
      if expect[key] != actual[key]
        diff[key] = "expect: #{expect[key]}, actual: #{actual[key]}"
      end
    end

    diff.empty? ? "" : "#{diff}\n"
  end

  private

  def get_elements(xml, filter_attributes)
    handler = Elements.new(filter_attributes)
    Oga.sax_parse_xml(handler, xml)
    handler.elements
  end
end
