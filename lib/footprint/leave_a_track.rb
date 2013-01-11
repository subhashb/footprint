module Footprint
  module Model
    
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      def leave_a_track
        class_attribute :leaving_a_track
        self.leaving_a_track = true
      end
    end
  end
end