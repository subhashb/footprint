class LeopardFootprint
  include Mongoid::Document
  store_in collection: "leopards"
  field :id, type: Integer
  field :name, type: String
  field :region, type: String
  field :height, type: Integer
  field :weight, type: Integer
  field :strength, type: Integer
  field :speed, type: Integer
  field :aggression, type: Integer
  field :notes, type: String
  field :created_at, type: Time
  field :updated_at, type: Time
  field :phase, type: String
  field :parent_id, type: Integer
  field :parent_type, type: String
end
