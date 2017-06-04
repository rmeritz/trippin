Geocoder.configure(lookup: :test)

RSpec.configure do |config|
  config.after(:each) do
    Geocoder::Lookup::Test.reset
  end
end
