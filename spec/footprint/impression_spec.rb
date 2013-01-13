require "spec_helper"

describe Footprint::Impression do
  before(:each) do
    @yeti = FactoryGirl.create(:yeti)
  end
  
  context "is linked" do
    it "to parent" do
      expect(@yeti.impressions.first.parent_id).to eq(@yeti.id)
    end
  end
  
  context "shares attributes of parent" do
    it "like name" do
      expect(@yeti.impressions.first.name).to eq(@yeti.name)
    end
  end
  
  context "records mandatory criteria" do
    it "like parent_id" do
      expect(@yeti.impressions.first.parent_id).to eq(@yeti.id)
    end
    
    it "like parent_type" do
      expect(@yeti.impressions.first.parent_type).to eq(@yeti.name)
    end
    
    context "like phase" do
      it "of birth" do
        expect(@yeti.impressions.first.phase).to eq("create")
      end
      
      it "of growth" do
        @yeti.name = "Changed"
        @yeti.save
        expect(@yeti.impressions.last.phase).to eq("update")
      end
      
      it "of death" do
        @yeti.destroy
        expect(@yeti.impressions.last.phase).to eq("destroy")
      end
    end
  end
end