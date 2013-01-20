require 'singleton'

module Footprint
  class Config
    include Singleton
    attr_accessor :enabled

    def initialize
      @enabled         = true # Footprint is on by default
    end
  end
end