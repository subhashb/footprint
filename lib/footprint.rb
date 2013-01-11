require "footprint/version"
require "footprint/impression"
require "footprint/leave_a_track"

require "active_support/inflector"

module Footprint
  
end

ActiveSupport.on_load(:active_record) do
  include Footprint::Model
end
