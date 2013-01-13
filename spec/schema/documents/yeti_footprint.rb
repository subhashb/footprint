class YetiFootprint
  include Mongoid::Document
  store_in collection: "yetis"
  field :id, type: Integer
  field :name, type: String
  field :gender, type: String
  field :region, type: String
  field :height, type: Integer
  field :weight, type: Integer
  field :strength, type: Integer
  field :aggression, type: Integer
  field :mass, type: Integer
  field :notes, type: String
  field :created_at, type: Time
  field :updated_at, type: Time
end
