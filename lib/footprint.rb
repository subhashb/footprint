require "footprint/version"
require "footprint/impression"
require "footprint/leave_a_track"

require "generators/footprint/document/document_generator"

require "active_support/inflector"

module Footprint
  
end

ActiveSupport.on_load(:active_record) do
  include Footprint::Model
end
