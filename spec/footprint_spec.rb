require 'spec_helper'

describe "Footprint" do
  
  describe "ActiveRecord" do
    it "checks if Yeti is really an ActiveRecord::Base class" do
      expect(Yeti.superclass.name).to eq("ActiveRecord::Base")
    end
  end
  
end