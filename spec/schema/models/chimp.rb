class Chimp < ActiveRecord::Base
  attr_accessible :aggression, :height, :name, :notes, :region, :speed, :strength, :weight
  leave_a_track :impression_type => 'full'
end