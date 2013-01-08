require 'spec_helper'

describe "Footprint" do
  it "should return correct version string" do
    Footprint.version_string.should == "Footprint version #{Footprint::VERSION}"
  end
end