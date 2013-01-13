module Footprint
  module Model
    
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      
      def leave_a_track
        send :include, InstanceMethods
        
        class_attribute :impressions_association_name
        self.impressions_association_name = self.name + "Footprint"
        
        class_attribute :impressions_class
        self.impressions_class = Object.const_get(self.impressions_association_name)
        
        class_attribute :leaving_a_track
        self.leaving_a_track = true
        
        after_create  :impression_of_create
        after_update  :impression_of_update
        after_destroy :impression_of_destroy
      end
      
    end
    
    module InstanceMethods
      def impressions
        impressions_class.where(parent_id: self.id)
      end
      
      private 
      
      def impression_of_create
        impressions_class.create attributes_for_impression.merge(mandatory_attributes).merge(:phase => "create")
      end
      
      def impression_of_update
        impressions_class.create attributes_for_impression.merge(mandatory_attributes).merge(:phase => "update") if changed?
      end
      
      def impression_of_destroy
        impressions_class.create attributes_for_impression.merge(mandatory_attributes).merge(:phase => "destroy")
      end
      
      def mandatory_attributes
        Hash.new.merge(:parent_id => self.id, :parent_type => self.name)
      end
      
      def attributes_for_impression
        self.attributes.except(:id)
      end
    end
    
  end
end