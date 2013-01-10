require 'spec_helper'

describe "Footprint" do
  
  describe "ActiveRecord" do
    it "checks if Yeti is really an ActiveRecord::Base class" do
      Yeti.superclass.name.should eq "ActiveRecord::Base"
    end
  end
  
end