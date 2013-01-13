class Yeti < ActiveRecord::Base
  attr_accessible :aggression, :height, :mass, :name, :notes, :region, :strength, :weight
  leave_a_track
end