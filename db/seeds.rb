User.create(
  provider: "google_oauth2",
  uid: "10003232456654465753",
  name: "Ned Flanders",
  oauth_token: "very_long_token"
)

User.create(
  provider: "google_oauth2",
  uid: "10003232456654465750",
  name: "Lenny Leonard",
  oauth_token: "very_long_token"
)

User.create(
  provider: "google_oauth2",
  uid: "10003232456654465751",
  name: "Carl Carlson",
  oauth_token: "very_long_token"
)

User.create(
  provider: "google_oauth2",
  uid: "10003232456654465752",
  name: "Maude Flanders",
  oauth_token: "very_long_token"
)

User.create(
  provider: "google_oauth2",
  uid: "10003232456654465754",
  name: "Clancy Wiggum",
  oauth_token: "very_long_token"
)

User.create(
  provider: "google_oauth2",
  uid: "10003232456654465755",
  name: "Moe Syzlak",
  oauth_token: "very_long_token"
)

# All 59 National Parks
[
  Park.create(
    name: "Acadia",
    state: "Maine",
    park_type: "National Park",
    latitude: 44.339,
    longitude: -68.273,
    nps_url: "https://www.nps.gov/acad/index.htm"
  ),

  Park.create(
    name: "American Samoa",
    state: "US Territories",
    park_type: "National Park",
    latitude: -14.258,
    longitude: -170.683,
    nps_url: "https://www.nps.gov/npsa/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Arches",
    state: "Utah",
    park_type: "National Park",
    latitude: 38.733,
    longitude: -109.593,
    nps_url: "https://www.nps.gov/arch/index.htm"
  ),

  Park.create(
    name: "Badlands",
    state: "South Dakota",
    park_type: "National Park",
    latitude: 43.855,
    longitude: -102.340,
    nps_url: "https://www.nps.gov/badl/index.htm"
  ),

  Park.create(
    name: "Big Bend",
    state: "Texas",
    park_type: "National Park",
    latitude: 29.128,
    longitude: -103.243,
    nps_url: "https://www.nps.gov/bibe/index.htm"
  ),

  Park.create(
    name: "Biscayne",
    state: "Florida",
    park_type: "National Park",
    latitude: 25.482,
    longitude: -80.208,
    nps_url: "https://www.nps.gov/bisc/index.htm"
  ),

  Park.create(
    name: "Black Canyon of the Gunnison",
    state: "Colorado",
    park_type: "National Park",
    latitude: 38.574,
    longitude: -107.742,
    nps_url: "https://www.nps.gov/blca/index.htm"
  ),

  Park.create(
    name: "Bryce Canyon",
    state: "Utah",
    park_type: "National Park",
    latitude: 37.593,
    longitude: -112.187,
    nps_url: "https://www.nps.gov/brca/index.htm"
  ),

  Park.create(
    name: "Canyonlands",
    state: "Utah",
    park_type: "National Park",
    latitude: 38.327,
    longitude: -109.878,
    nps_url: "https://www.nps.gov/cany/index.htm"
  ),

  Park.create(
    name: "Capitol Reef",
    state: "Utah",
    park_type: "National Park",
    latitude: 38.367,
    longitude: -111.262,
    nps_url: "https://www.nps.gov/care/index.htm"
  ),

  Park.create(
    name: "Carlsbad Caverns",
    state: "New Mexico",
    park_type: "National Park",
    latitude: 32.148,
    longitude: -104.557,
    nps_url: "https://www.nps.gov/cave/index.htm"
  ),

  Park.create(
    name: "Channel Islands",
    state: "California",
    park_type: "National Park",
    latitude: 34.003,
    longitude: -119.710,
    nps_url: "https://www.nps.gov/chis/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Conagree",
    state: "South Carolina",
    park_type: "National Park",
    latitude: 33.793,
    longitude: -80.7811,
    nps_url: "https://www.nps.gov/cong/index.htm"
  ),

  Park.create(
    name: "Crater Lake",
    state: "Oregon",
    park_type: "National Park",
    latitude: 42.868,
    longitude: -122.169,
    nps_url: "https://www.nps.gov/crla/index.htm"
  ),

  Park.create(
    name: "Cuyahoga Valley",
    state: "Ohio",
    park_type: "National Park",
    latitude: 41.281,
    longitude: -81.568,
    nps_url: "https://www.nps.gov/cuva/index.htm"
  ),

  Park.create(
    name: "Death Valley",
    state: "California",
    park_type: "National Park",
    latitude: 36.505,
    longitude: -117.079,
    nps_url: "https://www.nps.gov/deva/index.htm"
  ),

  Park.create(
    name: "Denali",
    state: "Alaska",
    park_type: "National Park",
    latitude: 63.115,
    longitude: -151.193,
    nps_url: "https://www.nps.gov/dena/index.htm"
  ),

  Park.create(
    name: "Dry Tortugas",
    state: "Florida",
    park_type: "National Park",
    latitude: 24.629,
    longitude: -82.873,
    nps_url: "https://www.nps.gov/drto/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Everglades",
    state: "Florida",
    park_type: "National Park",
    latitude: 25.287,
    longitude: -80.899,
    nps_url: "https://www.nps.gov/ever/index.htm"
  ),

  Park.create(
    name: "Gates of the Arctic",
    state: "Alaska",
    park_type: "National Park",
    latitude: 67.915,
    longitude: -153.464,
    nps_url: "https://www.nps.gov/gaar/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Glacier",
    state: "Montana",
    park_type: "National Park",
    latitude: 48.760,
    longitude: -113.787,
    nps_url: "https://www.nps.gov/glac/index.htm"
  ),

  Park.create(
    name: "Glacier Bay",
    state: "Alaska",
    park_type: "National Park",
    latitude: 58.666,
    longitude: -136.900,
    nps_url: "https://www.nps.gov/glba/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Grand Canyon",
    state: "Arizona",
    park_type: "National Park",
    latitude: 36.107,
    longitude: -112.113,
    nps_url: "https://www.nps.gov/grca/index.htm"
  ),

  Park.create(
    name: "Grand Teton",
    state: "Wyoming",
    park_type: "National Park",
    latitude: 43.790,
    longitude: -110.682,
    nps_url: "https://www.nps.gov/grte/index.htm"
  ),

  Park.create(
    name: "Great Basin",
    state: "Nevada",
    park_type: "National Park",
    latitude: 38.983,
    longitude: -114.300,
    nps_url: "https://www.nps.gov/grba/index.htm"
  ),

  Park.create(
    name: "Great Sand Dunes",
    state: "Colorado",
    park_type: "National Park",
    latitude: 37.792,
    longitude: -105.594,
    nps_url: "https://www.nps.gov/grsa/index.htm"
  ),

  Park.create(
    name: "Great Smoky Mountains",
    state: "Tennessee",
    park_type: "National Park",
    latitude: 35.612,
    longitude: -83.490,
    nps_url: "https://www.nps.gov/grsm/index.htm"
  ),

  Park.create(
    name: "Guadalupe Mountains",
    state: "Texas",
    park_type: "National Park",
    latitude: 31.945,
    longitude: -104.873,
    nps_url: "https://www.nps.gov/gumo/index.htm"
  ),

  Park.create(
    name: "Haleakalā",
    state: "Hawaii",
    park_type: "National Park",
    latitude: 20.720,
    longitude: -156.155,
    nps_url: "https://www.nps.gov/hale/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Hawai'i Volcanoes",
    state: "Hawaii",
    park_type: "National Park",
    latitude: 19.419,
    longitude: -155.289,
    nps_url: "https://www.nps.gov/havo/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Hot Springs",
    state: "Arkansas",
    park_type: "National Park",
    latitude: 34.522,
    longitude: -93.042,
    nps_url: "https://www.nps.gov/hosp/index.htm"
  ),

  Park.create(
    name: "Isle Royale",
    state: "Michigan",
    park_type: "National Park",
    latitude: 47.996,
    longitude: -88.909,
    nps_url: "https://www.nps.gov/isro/index.htm"
  ),

  Park.create(
    name: "Joshua Tree",
    state: "California",
    park_type: "National Park",
    latitude: 33.873,
    longitude: -115.901,
    nps_url: "https://www.nps.gov/jotr/index.htm"
  ),

  Park.create(
    name: "Katmai",
    state: "Alaska",
    park_type: "National Park",
    latitude: 58.598,
    longitude: -154.694,
    nps_url: "https://www.nps.gov/katm/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Kenai Fjords",
    state: "Alaska",
    park_type: "National Park",
    latitude: 60.044,
    longitude: -149.816,
    nps_url: "https://www.nps.gov/kefj/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Kings Canyon",
    state: "California",
    park_type: "National Park",
    latitude: 36.888,
    longitude: -118.555,
    nps_url: "https://www.nps.gov/seki/index.htm"
  ),

  Park.create(
    name: "Kobuk Valley",
    state: "Alaska",
    park_type: "National Park",
    latitude: 67.336,
    longitude: -159.124,
    nps_url: "https://www.nps.gov/kova/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Lake Clark",
    state: "Alaska",
    park_type: "National Park",
    latitude: 60.413,
    longitude: -154.324,
    nps_url: "https://www.nps.gov/lacl/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Lassen Volcanic",
    state: "California",
    park_type: "National Park",
    latitude: 40.498,
    longitude: -121.421,
    nps_url: "https://www.nps.gov/lavo/index.htm"
  ),

  Park.create(
    name: "Mammoth Cave",
    state: "Kentucky",
    park_type: "National Park",
    latitude: 37.187,
    longitude: -86.101,
    nps_url: "https://www.nps.gov/maca/index.htm"
  ),

  Park.create(
    name: "Mesa Verde",
    state: "Colorado",
    park_type: "National Park",
    latitude: 37.231,
    longitude: -108.462,
    nps_url: "https://www.nps.gov/meve/index.htm"
  ),

  Park.create(
    name: "Mount Rainier",
    state: "Washington",
    park_type: "National Park",
    latitude: 46.880,
    longitude: -121.727,
    nps_url: "https://www.nps.gov/mora/index.htm"
  ),

  Park.create(
    name: "North Cascades",
    state: "Washington",
    park_type: "National Park",
    latitude: 48.772,
    longitude: -121.299,
    nps_url: "https://www.nps.gov/noca/index.htm"
  ),

  Park.create(
    name: "Olympic",
    state: "Washington",
    park_type: "National Park",
    latitude: 47.802,
    longitude: -123.604,
    nps_url: "https://www.nps.gov/olym/index.htm"
  ),

  Park.create(
    name: "Petrified Forest",
    state: "Arizona",
    park_type: "National Park",
    latitude: 34.910,
    longitude: -109.807,
    nps_url: "https://www.nps.gov/pefo/index.htm"
  ),

  Park.create(
    name: "Pinnacles",
    state: "California",
    park_type: "National Park",
    latitude: 36.491,
    longitude: -121.183,
    nps_url: "https://www.nps.gov/pinn/index.htm"
  ),

  Park.create(
    name: "Redwood",
    state: "California",
    park_type: "National Park",
    latitude: 41.213,
    longitude: -124.005,
    nps_url: "https://www.nps.gov/redw/index.htm"
  ),

  Park.create(
    name: "Rocky Mountain",
    state: "Colorado",
    park_type: "National Park",
    latitude: 40.343,
    longitude: -105.684,
    nps_url: "https://www.nps.gov/romo/index.htm"
  ),

  Park.create(
    name: "Saguaro",
    state: "Arizona",
    park_type: "National Park",
    latitude: 32.297,
    longitude: -111.167,
    nps_url: "https://www.nps.gov/sagu/index.htm"
  ),

  Park.create(
    name: "Sequoia",
    state: "California",
    park_type: "National Park",
    latitude: 36.486,
    longitude: -118.566,
    nps_url: "https://www.nps.gov/seki/index.htm"
  ),

  Park.create(
    name: "Shenandoah",
    state: "Virginia",
    park_type: "National Park",
    latitude: 38.293,
    longitude: -78.680,
    nps_url: "https://www.nps.gov/shen/index.htm"
  ),

  Park.create(
    name: "Theodore Roosevelt",
    state: "North Dakota",
    park_type: "National Park",
    latitude: 46.979,
    longitude: -103.539,
    nps_url: "https://www.nps.gov/thro/index.htm"
  ),

  Park.create(
    name: "Virgin Islands",
    state: "US Territories",
    park_type: "National Park",
    latitude: 18.342,
    longitude: -64.749,
    nps_url: "https://www.nps.gov/viis/index.htm",
    drivable: false
  ),

  Park.create(
    name: "Voyageurs",
    state: "Minnesota",
    park_type: "National Park",
    latitude: 48.484,
    longitude: -92.827,
    nps_url: "https://www.nps.gov/voya/index.htm"
  ),

  Park.create(
    name: "Wind Cave",
    state: "South Dakota",
    park_type: "National Park",
    latitude: 43.605,
    longitude: -103.421,
    nps_url: "https://www.nps.gov/wica/index.htm"
  ),

  Park.create(
    name: "Wrangell-St. Elias",
    state: "Alaska",
    park_type: "National Park",
    latitude: 61.710,
    longitude: -142.986,
    nps_url: "https://www.nps.gov/wrst/index.htm"
  ),

  Park.create(
    name: "Yellowstone",
    state: "Wyoming",
    park_type: "National Park",
    latitude: 44.428,
    longitude: -110.589,
    nps_url: "https://www.nps.gov/yell/index.htm"
  ),

  Park.create(
    name: "Yosemite",
    state: "California",
    park_type: "National Park",
    latitude: 37.865,
    longitude: -119.538,
    nps_url: "https://www.nps.gov/yose/index.htm"
  ),

  Park.create(
    name: "Zion",
    state: "Utah",
    park_type: "National Park",
    latitude: 37.298,
    longitude: -113.026,
    nps_url: "https://www.nps.gov/zion/index.htm"
  )
]

Vacation.create(
  name: "Triperino to Colorado",
  location: "Denver, CO, United States",
  description: "A quick ride to the folks and some high-diddly-ho mountains.",
  display_public: true,
  start_date: Date.new(2016,5,16),
  end_date: Date.new(2016,5,21),
  user_id: 1
)

  Visit.create(
    user_id: 1,
    vacation_id: 1,
    park_id: 48,
    start_date: Date.new(2016,5,16),
    end_date: Date.new(2016,5,18)
  )

  Visit.create(
    user_id: 1,
    vacation_id: 1,
    park_id: 26,
    start_date: Date.new(2016,5,18),
    end_date: Date.new(2016,5,20)
  )

Vacation.create(
  name: "Got lost outside Las Vegas",
  location: "Las Vegas, NV, United States",
  description: "Carl and I took at wrong turn at Treasure Island.",
  display_public: true,
  start_date: Date.new(2014,9,7),
  end_date: Date.new(2014,9,13),
  user_id: 2
)

  Visit.create(
    user_id: 2,
    vacation_id: 2,
    park_id: 59,
    start_date: Date.new(2014,9,7),
    end_date: Date.new(2014,9,8)
  )

  Visit.create(
    user_id: 2,
    vacation_id: 2,
    park_id: 23,
    start_date: Date.new(2014,9,10),
    end_date: Date.new(2014,9,13),
  )

  Visit.create(
    user_id: 2,
    vacation_id: 2,
    park_id: 8,
    start_date: Date.new(2014,9,8),
    end_date: Date.new(2014,9,10)
  )


Vacation.create(
  name: "Bushwhacked in Vegas",
  location: "Las Vegas, NV, United States",
  description: "I'm never letting Lenny drive Again",
  display_public: false,
  start_date: Date.new(2014,9,7),
  end_date: Date.new(2014,9,13),
  user_id: 3
)

  Visit.create(
    user_id: 3,
    vacation_id: 3,
    park_id: 59,
    start_date: Date.new(2014,9,7),
    end_date: Date.new(2014,9,8)
  )

  Visit.create(
    user_id: 3,
    vacation_id: 3,
    park_id: 8,
    start_date: Date.new(2014,9,8),
    end_date: Date.new(2014,9,10)
  )

  Visit.create(
    user_id: 3,
    vacation_id: 3,
    park_id: 23,
    start_date: Date.new(2014,9,10),
    end_date: Date.new(2014,9,12)
  )

Vacation.create(
  name: "Lovely time in the Moutains",
  location: "Tacoma, WA, United States",
  description: "Neddy and I took the boys out to see Mt. Rainer. Rod and Todd were so excited to be praying at high altitude!",
  display_public: true,
  start_date: Date.new(2015,5,22),
  end_date: Date.new(2015,5,27),
  user_id: 4
)

  Visit.create(
    user_id: 4,
    vacation_id: 4,
    park_id: 42,
    start_date: Date.new(2015,5,22),
    end_date: Date.new(2015,5,25)
  )

  Visit.create(
    user_id: 4,
    vacation_id: 4,
    park_id: 44,
    start_date: Date.new(2015,5,25),
    end_date: Date.new(2015,5,27)
  )

Vacation.create(
  name: "Lost my badge in Nashville, turns out it was in a cave!",
  location: "Nashville, TN, United States",
  description: "",
  display_public: true,
  start_date: Date.new(2017,4,12),
  end_date: Date.new(2017,4,16),
  user_id: 5
)

  Visit.create(
    user_id: 5,
    vacation_id: 5,
    park_id: 40,
    start_date: Date.new(2017,4,12),
    end_date: Date.new(2017,4,16)
  )

Vacation.create(
  name: "Bear viewing up north",
  location: "Anchorage, AK, United States",
  description: "Ralphie wanted to see some bears, but I had to keep him from getting too close",
  display_public: true,
  start_date: Date.new(2016,6,19),
  end_date: Date.new(2016,6,25),
  user_id: 5
)

  Visit.create(
    user_id: 5,
    vacation_id: 6,
    park_id: 34,
    start_date: Date.new(2016,6,20),
    end_date: Date.new(2016,6,24)
  )

Vacation.create(
  name: "Turns out there's some stuff to see here",
  location: "Springfield, IL, United States",
  description: "While the bar was closed down for to spray for 'mites, I hit the road",
  display_public: true,
  start_date: Date.new(2016,7,2),
  end_date: Date.new(2016,7,15),
  user_id: 6
)

  Visit.create(
    user_id: 6,
    vacation_id: 7,
    park_id: 4,
    start_date: Date.new(2016,7,2),
    end_date: Date.new(2016,7,4)
  )

  Visit.create(
    user_id: 6,
    vacation_id: 7,
    park_id: 55,
    start_date: Date.new(2016,7,4),
    end_date: Date.new(2016,7,5)
  )

  Visit.create(
    user_id: 6,
    vacation_id: 7,
    park_id: 57,
    start_date: Date.new(2016,7,6),
    end_date: Date.new(2016,7,10)
  )

  Visit.create(
    user_id: 6,
    vacation_id: 7,
    park_id: 24,
    start_date: Date.new(2016,7,11),
    end_date: Date.new(2016,7,13)
  )
