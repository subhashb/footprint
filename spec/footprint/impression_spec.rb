require "spec_helper"

describe Footprint::Impression do
  context "with Footprint enabled" do
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
        expect(@yeti.impressions.first.parent_type).to eq(@yeti.class.name)
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
  
    context "returns" do
      it "an impression in general cases" do
        expect(@yeti.impressions.first.class).to be_instance_of(YetiFootprint.class)
      end
    
      it "the parent type when asked" do
        expect(@yeti.impressions.first.as_parent).to be_instance_of(Yeti)
      end
    
      it "returns its parent when asked" do
        expect(@yeti.impressions.first.as_parent.id).to eq(@yeti.impressions.first.parent_id)
      end
    end
  end
  
  context "with Footprint disabled" do
    before(:all) do
      Footprint.enabled = false
    end
    
    before(:each) do
      @yeti = FactoryGirl.create(:yeti)
    end
    
    it "leaves an impression when loaded" do
      @yeti.first_step
      expect(@yeti.impressions.last.phase).to eq("load")
    end
    
    after(:all) do
      Footprint.enabled = true
    end
  end
end