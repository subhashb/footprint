FactoryGirl.define do
  factory :yeti do
    sequence(:name) { |n| "Yeti#{n}" }
    notes           "Yet to Start Tracking"
    region          "Himalayas"
    
    trait :male do
      gender        "Male"
    end
    trait :female do
      gender        "Female"
    end
    
    trait :dangerous do
      name          "Ivan"
      aggression    9
      mass          9
      strength      10
      height        325
      weight        1400
      region        "Himalayas"
      notes         "Stay away and take evasive measures - Extremely dangerous"
    end
    trait :tameable do
      name          "Johanne"
      aggression    1
      mass          8
      strength      6
      height        310
      weight        1100
      region        "Amazon"
      notes         "Gentle and harmless"
    end
    trait :huge do
      name          "Duncan"
      aggression    5
      mass          10
      strength      9
      height        375
      weight        1700
      region        "Andes"
      notes         "Unknown behavior - Be wary of proximity"
    end
    
    factory :male_yeti, traits: [:male]
    factory :female_yeti, traits: [:female]
    
    factory :male_dangerous_yeti, traits: [:male, :dangerous]
    factory :female_tameable_yeti, traits: [:female, :tameable]
    factory :male_huge_yeti, traits: [:male, :huge]
    factory :female_dangerous_yeti, traits: [:female, :dangerous, name: "Victoria"]
    factory :male_tameable_yeti, traits: [:male, :tameable, name: "Beethoven"]
    factory :female_huge_yeti, traits: [:female, :huge, name: "Hidimbi"]
  end
end