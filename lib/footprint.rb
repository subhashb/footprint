require "footprint/version"
require "footprint/impression"
require "footprint/leave_a_track"
require "footprint/config"

require "generators/footprint/document/document_generator"

require "active_support/inflector"

module Footprint
  def self.enabled=(value)
    Footprint.config.enabled = value
  end

  # Returns `true` if Footprint is on, `false` otherwise.
  # Footprint is enabled by default.
  def self.enabled?
    !!Footprint.config.enabled
  end
  
  # Returns PaperTrail's configuration object.
  def self.config
    @@config ||= Footprint::Config.instance
  end
end

ActiveSupport.on_load(:active_record) do
  include Footprint::Model
end
