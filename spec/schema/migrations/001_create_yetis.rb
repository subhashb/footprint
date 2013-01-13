class CreateYetis < ActiveRecord::Migration
  def self.up
    create_table :yetis, :force => true do |t|
      t.string        :name
      t.string        :gender
      t.string        :region
      t.integer       :height
      t.integer       :weight
      t.integer       :strength
      t.integer       :aggression
      t.integer       :mass
      t.string        :notes
      t.timestamps
    end
  end
  
  def self.down
    drop_table :yetis
  end
end