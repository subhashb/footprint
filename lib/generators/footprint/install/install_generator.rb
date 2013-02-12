require "rails/generators"

module Footprint
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      def install_footprint
        begin
          generate "mongoid:config"
        rescue Exception => e
          Logger.new(STDOUT).error("Unknonwn exception #{e.message}")
        end
      end
    end
  end
end