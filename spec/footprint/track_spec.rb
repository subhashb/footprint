#Is a set of Impressions (Versions)
require "spec_helper"

describe Footprint::Model do
  context "with tracking enabled" do
    it "says yes to leaving_a_track?" do
      Yeti.new.leaving_a_track.should be_true
    end
  end
  
  context "with tracking disabled" do
    it "does not respond to leaving_a_track?" do
      Leopard.new.respond_to?(:leaving_a_track).should be_false
    end
  end
end