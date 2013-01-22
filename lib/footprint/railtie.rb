require "footprint"
require "rails"

module Rails
  module Footprint
    class Railtie < Rails::Railtie
      rake_tasks do
        load "tasks/footprint.rake"
      end
    end
  end
end
