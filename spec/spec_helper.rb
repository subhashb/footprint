#Required for ammeter - start
require 'rails/all'

module Footprint
  class Application < ::Rails::Application
  end
end
#Required for ammeter - end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "schema/models")
DOCUMENTS = File.join(File.dirname(__FILE__), "schema/documents")
$LOAD_PATH.unshift(MODELS)
$LOAD_PATH.unshift(DOCUMENTS)

require 'footprint'
require 'active_record'
require 'ammeter/init'
require 'factory_girl'
require "mongoid"

# Autoload every model for the test suite that sits in spec/schema/models.
Dir[ File.join(MODELS, "*.rb") ].sort.each do |file|
  name = File.basename(file, ".rb")
  autoload name.camelize.to_sym, name
end

# Autoload every document for the test suite that sits in spec/schema/documents.
Dir[ File.join(DOCUMENTS, "*.rb") ].sort.each do |file|
  name = File.basename(file, ".rb")
  autoload name.camelize.to_sym, name
end

# To load FactoryGirl in a non-rails environment
FactoryGirl.find_definitions

# Mongoid Configuration - start
# These environment variables can be set if wanting to test against a database
# that is not on the local machine.
ENV["MONGOID_SPEC_HOST"] ||= "localhost"
ENV["MONGOID_SPEC_PORT"] ||= "27017"

# These are used when creating any connection in the test suite.
HOST = ENV["MONGOID_SPEC_HOST"]
PORT = ENV["MONGOID_SPEC_PORT"].to_i

# Moped.logger.level = Logger::DEBUG
# Mongoid.logger.level = Logger::DEBUG

# When testing locally we use the database named mongoid_test. However when
# tests are running in parallel on Travis we need to use different database
# names for each process running since we do not have transactions and want a
# clean slate before each spec run.
def database_id
  "mongoid_test"
end

# Set the database that the spec suite connects to.
Mongoid.configure do |config|
  config.allow_dynamic_fields = false
  config.connect_to(database_id, consistency: :strong)
end
# Mongoid Configuration - end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
  
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  
  #Initialize database connection
  ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "db/fpdb"
  
  #Initialize Mongoid
  # Drop all collections and clear the identity map before each spec.
  config.before(:each) do
    Mongoid.purge!
    Mongoid::IdentityMap.clear
  end
end
