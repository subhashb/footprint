require "rails/generators"

module Footprint
  module Generators
    class DocumentGenerator < Rails::Generators::Base
      argument :model_name, :type => :string, :desc => "Active Record model to generate Document from"
    
      def run_mongoid_generator
        begin
          attributes = Object.const_get(model_name).columns_hash.except("id").values.collect { |c| c.name + ":" + type_class(c.sql_type) }.join(" ") + " phase:string parent_id:integer parent_type:string"
          generate "mongoid:model", "#{model_name.camelize}Footprint #{attributes} --collection=#{model_name.downcase.pluralize}"
        rescue Exception => e
          Logger.new(STDOUT).error("ActiveRecord model \"#{model_name.to_s}\" was not found")
        end
      end
    
      private
    
      def type_class(sql_type)
        return "string" if sql_type.to_s == "varchar(255)"
        return sql_type.downcase
      end
    end
  end
end