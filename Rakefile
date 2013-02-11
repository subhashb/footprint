require "bundler/gem_tasks"
require 'active_record'
require 'logger'
require 'rspec/core/rake_task'

task :default => :spec
RSpec::Core::RakeTask.new

namespace :db do
  desc "Migrate the database through scripts in spec/schema/migrations"
  task :prepare => :environment do
    ActiveRecord::Migration.verbose = true
    
    MIGRATIONS = File.join(File.dirname(__FILE__), "spec/schema/migrations")
    ActiveRecord::Migrator.migrate(MIGRATIONS)
  end

  task :environment do
    Dir.mkdir("db") unless File.exist?("db")
    File.delete('db/fpdb') if File.exist?('db/fpdb')
    
    ActiveRecord::Base.establish_connection adapter: "sqlite3", database: "db/fpdb"
    ActiveRecord::Base.logger = Logger.new(File.open('db/database.log', 'a')) 
  end
end