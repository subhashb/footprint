require "spec_helper"

describe Footprint::Model do
  before(:each) do
    @yeti = FactoryGirl.build(:yeti)
  end

  context "during its lifetime" do
    it "can be conceived" do
      expect( @yeti ).to be_valid
    end
    
    it "can be born" do
      expect{ @yeti.save }.to change{Yeti.count}.by(1)
    end
    
    it "can grow" do
      @yeti.save
      expect{ @yeti.update_attributes(:height => 100) }.not_to change{Yeti.count}
    end
    
    it "can die" do
      @yeti.save
      expect { @yeti.destroy }.to change{Yeti.count}.by(-1)
    end
  end
  
  context "when globally" do
    context "enabled" do
      it "leaves a track" do
        expect { @yeti.save }.to change{YetiFootprint.count}.by(1)
      end
    end
    
    context "disabled" do
      before(:all) do
        Footprint.enabled = false
      end
    
      it "does not leave a track" do
        expect { @yeti.save }.to_not change{YetiFootprint.count}.by(1)
      end
      
      after(:all) do
        Footprint.enabled = true
      end
    end
  end
  
  context "with tracking enabled" do
    it "can be monitored" do
      expect( Yeti.new ).to be_leaving_a_track
    end
    
    context "while alive" do
      context "will leave an impression" do
        it "when born" do
          expect { @yeti.save }.to change{YetiFootprint.count}.by(1)
        end
        
        it "when growing" do
          @yeti.save
          @yeti.name = @yeti.name + "Changed"
          expect { @yeti.save }.to change{YetiFootprint.count}.by(1)
        end
        
        it "when dead" do
          @yeti.save
          expect { @yeti.destroy }.to change{YetiFootprint.count}.by(1)
        end
      end
      
      context "when saved multiple times" do
        it "will store multiple impressions" do
          expect { 
            @yeti.save 
            @yeti.name = @yeti.name + "Changed"
            @yeti.save
          }.to change{YetiFootprint.count}.by(2)
        end
      end
      
      context "will not leave an impression" do
        it "if there is no growth" do
          @yeti.save
          expect { @yeti.save }.to_not change{YetiFootprint.count}
        end
      end
    end
  end
  
  context "with no tracking" do
    it "does not respond to leaving_a_track" do
      expect(Leopard.new).to_not respond_to(:leaving_a_track)
    end
  end
  
  context "can be loaded" do
    before(:all) do
      @yetis = FactoryGirl.create_list(:yeti, 25)
    end
    it "with phase as load" do
      @yetis.each do |yeti|
        expect { yeti.first_step }.to change{YetiFootprint.count}.by(1)
      end
    end
  end
end