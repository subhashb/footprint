module Footprint
  module Model
    
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      # Declare this in your model to track every create, update, and destroy.  Each version of
      # the model is available as its `impressions`
      #
      # Options:
      # :impression_type      delta or full (optional; defaults to delta).
      def leave_a_track(options = {})
        send :include, InstanceMethods
        
        class_attribute :impressions_association_name
        self.impressions_association_name = self.name + "Footprint"
        
        class_attribute :impressions_class
        self.impressions_class = Object.const_get(self.impressions_association_name)
        
        class_attribute :leaving_a_track
        self.leaving_a_track = true
        
        class_attribute :footprint_options
        self.footprint_options = options.dup
        
        class_attribute :leave_full_impression
        self.leave_full_impression = footprint_options[:impression_type] == "full" ? true : false
        
        after_create  :impression_of_create
        after_update  :impression_of_update
        after_destroy :impression_of_destroy
      end
      
    end
    
    module InstanceMethods
      def impressions
        impressions_class.where(parent_id: self.id)
      end
      
      def first_step
        impressions_class.leave self, "load"
      end
      
      private 
      
      def impression_of_create
        if tracking?
          impressions_class.leave self, "create"
        end
      end
      
      def impression_of_update
        if tracking? and changed?
          impressions_class.leave self, "update"
        end
      end
      
      def impression_of_destroy
        if tracking?
          impressions_class.leave self, "destroy"
        end
      end
      
      def tracking?
        Footprint.enabled?
      end
    end
  end
end