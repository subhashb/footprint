module Footprint
  module Model
    
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      
      def leave_a_track
        send :include, InstanceMethods
        
        class_attribute :versions_association_name
        self.versions_association_name = self.name + "Footprint"
        
        class_attribute :leaving_a_track
        self.leaving_a_track = true
        
        after_create  :record_create
      end
      
    end
    
    module InstanceMethods
      def record_create
        Object.const_get(self.class.versions_association_name).create self.attributes.except(:id).merge(:parent_id => self.id)
      end
      
      def impressions
        Object.const_get(self.class.versions_association_name).where(parent_id: self.id)
      end
    end
    
  end
end