class PageSourceSnapshot
  class Elements
    attr_reader :elements

    def initialize(filter_attributes = [])
      @filter_attributes = filter_attributes
      @elements = []
    end

    def on_element(namespace, name, attrs = {})
      @filter_attributes.each { |v| attrs.delete v } unless @filter_attributes.empty?
      @elements << [name, attrs]
    end
  end
end

