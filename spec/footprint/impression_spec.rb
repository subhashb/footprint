require "spec_helper"

describe Footprint::Impression do
  context "is linked" do
    it "to parent" do
      @yeti = FactoryGirl.create(:yeti)
      expect(@yeti.impressions.first.parent_id).to eq(@yeti.id)
    end
  end
  
  context "shares attributes of parent" do
    it "like name" do
      @yeti = FactoryGirl.create(:yeti)
      expect(@yeti.impressions.first.name).to eq(@yeti.name)
    end
  end
end