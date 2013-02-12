require "spec_helper"
require 'generators/footprint/install/install_generator'

describe Footprint::Generators::InstallGenerator do
  destination File.expand_path("../../../../../tmp", __FILE__)
  before { prepare_destination }
  
  describe "generates mongoid configuration" do
    # TODO Fix problem of 'scope/rails' not found in spec
    it "needs a fix problem 'script/rails' not found"
  end
end