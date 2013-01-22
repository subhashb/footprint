require 'csv'

namespace :footprint do
  desc "Load existing records into Footpring Document"
  task :load, [:model]  => [:environment] do |t, args|
    model = args[:model].constantize
    model.find_each(:batch_size => 1000) do |record|
      record.first_step
    end
  end
  
  desc "Extract impressions into a csv"
  task :extract, [:model] => [:environment] do |t, args|
    model = args[:model].constantize
    CSV.open("tmp/#{model.name.downcase.pluralize}-#{Date.today.strftime("%Y-%m-%d-%H-%m-%s")}.csv", "w") do |csv|
      csv << UserFootprint.fields.except("_id", "_type", "parent_id", "parent_type", "phase").keys
      model.impressions_class.where(:parent_type => model.name).each do |record|
        csv << record.attributes.except("_id", "_type", "parent_id", "parent_type", "phase").values
      end
    end
  end
end