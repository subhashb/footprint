require "spec_helper"

# Generators are not automatically loaded by Rails
require 'generators/footprint/document/document_generator'

describe Footprint::Generators::DocumentGenerator do
  destination File.expand_path("../../../../../tmp", __FILE__)
  before { prepare_destination }
  
  describe "with valid ActiveRecord model" do
    describe "generates a document" do
      # run_generator %w(Yeti)
      # subject { file('app/models/yeti_footprint.rb') }
      #it { should exist }
      # TODO Fix problem of 'scope/rails' not found in spec
      it "needs a fix problem 'script/rails' not found"
    end
  end
end