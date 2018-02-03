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
end

