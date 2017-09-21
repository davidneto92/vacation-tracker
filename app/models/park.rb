class Park < ApplicationRecord
  has_many :visits
  has_many :vacations, through: :visits
  has_many :users, through: :visits

  validates :park_type, inclusion: { in: ["National Park", "National Monument"] }

  STATES = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming",
    "US Territories",
  ].freeze

  ABBREVIATIONS = [
    "AL",
    "AK",
    "AZ",
    "AR",
    "CA",
    "CO",
    "CT",
    "DE",
    "FL",
    "GA",
    "HI",
    "ID",
    "IL",
    "IN",
    "IA",
    "KS",
    "KY",
    "LA",
    "ME",
    "MD",
    "MA",
    "MI",
    "MN",
    "MS",
    "MO",
    "MN",
    "NB",
    "NV",
    "NH",
    "NJ",
    "NM",
    "NY",
    "NC",
    "ND",
    "OH",
    "OK",
    "OR",
    "PA",
    "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VM",
    "VA",
    "WA",
    "WV",
    "WI",
    "WY",
    "USA",
].freeze

  def state_abbreviation
    return Park::ABBREVIATIONS[ Park::STATES.index(self.state) ]
  end

  def full_name
    "#{self.name} #{self.park_type}"
  end

  def self.drivable_park_list
    park_list = Park.all.where(drivable: true).order(:name)
    park_list = park_list.collect{ |park| ["#{park.full_name} - #{park.state_abbreviation}", park.id] }
  end
end
