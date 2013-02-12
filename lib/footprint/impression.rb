require 'mongoid'

module Footprint
  class Impression
    include Mongoid::Document
    
    def self.leave(model, phase)
      #FIXME Find better way of checking for "update" event
      if !model.leave_full_impression? and phase == "update"
        puts changed_attributes_for_impression(model).merge(mandatory_attributes(model)).merge(:phase => phase).to_s
        self.create changed_attributes_for_impression(model).merge(mandatory_attributes(model)).merge(:phase => phase)
      else
        self.create attributes_for_impression(model).merge(mandatory_attributes(model)).merge(:phase => phase)
      end
    end
    
    def as_parent
      parent = Object.const_get(parent_type).new (self.attributes).except("_id", "_type", "parent_id", "parent_type", "phase", "created_at", "updated_at")
      
      #id,created_at and updated_at  is attr-protected, so no mass-assignment
      parent.id = self.parent_id
      parent.created_at = self.created_at
      parent.updated_at = self.updated_at
      parent
    end
    
    private
    
    def self.mandatory_attributes(model)
      Hash.new.merge(:parent_id => model.id, :parent_type => model.class.name)
    end
    
    def self.attributes_for_impression(model)
      model.attributes.except(:id)
    end
    
    def self.changed_attributes_for_impression(model)
      model.attributes.select { |k,v| model.changed.include?(k) }
    end
  end
end