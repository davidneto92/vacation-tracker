FactoryGirl.define do
  factory :savedTrip do
    start_point
    destination_name
    destination_park_id
    found_parks
    directions_data
  end
end

# TODO: need to generate a fake trip to get the start_point hash,
# the directions data hash, and example park ids