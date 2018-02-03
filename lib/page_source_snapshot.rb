require "page_source_snapshot/version"
require 'oga'

class PageSourceSnapshot
  class Elements
    attr_reader :elements

    def initialize
      @elements = []
    end

    def on_element(namespace, name, attrs = {})
      @elements << [name, attrs]
    end
  end

  attr_reader :expect, :actual, :error_message

  def initialize(expect_xml, actual_xml)
    @expect = get_elements expect_xml
    @actual = get_elements actual_xml
    @error_message = nil
  end

  # @return [Array]
  def get_elements(xml)
    handler = Elements.new
    Oga.sax_parse_xml(handler, xml)
    handler.elements
  end

  def compare
    result = true
    message = ""
    @expect.zip(@actual).each do |e, a|
      if (e - a) != []
        message << error(e[1], a[1])
        result = false
      end
    end

    @error_message = message
    result
  end

  def error(expect, actual)
    return if expect.nil? || actual.nil?
    return "expect: #{expect}, actual: #{actual}" unless expect.is_a?(Hash) && actual.is_a?(Hash)

    e_keys = expect.keys
    # a_keys = actual.keys

    diff = {}

    e_keys.each do |key|
      if expect[key] != actual[key]
        diff[key] = "expect: #{expect[key]}, actual: #{actual[key]}"
      end
    end

    "#{diff}"
  end
end
