FactoryGirl.define do
  factory :trip do
    title "Spice Journey"
  end

  factory :point do
    trip
    name "Moracco"
    lat 31.791702
    long (-7.092619999999999)
  end
end
