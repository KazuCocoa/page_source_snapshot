class PageSourceSnapshot
  class Elements
    attr_reader :elements

    def initialize(ignore_attributes = [])
      raise "ignore_attributes should be Array. Not #{ignore_attributes.class}" unless ignore_attributes.is_a? Array

      @ignore_attributes = ignore_attributes
      @elements = []
    end

    def on_element(namespace, name, attrs = {})
      @ignore_attributes.each { |v| attrs.delete v } unless @ignore_attributes.empty?
      @elements << [name, attrs]
    end
  end
end
