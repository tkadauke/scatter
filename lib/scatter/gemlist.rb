module Scatter
  class Gemlist
    attr_accessor :gem_output
    
    def initialize(gem_output)
      @gem_output = gem_output
    end
    
    def self.parse(gem_output)
      new(gem_output)
    end
  end
end
