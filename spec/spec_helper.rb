# require 'webmock/rspec'

# WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups


  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.after(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DownloadHelpers::clear_downloads
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # config.before(:each) do
  #   stub_request(:get, "https://maps.googleapis.com/maps/api/directions/json?units=imperial&origin=Las%20Vegas,%20NV,%20United%20States&destination=Zion%20National%20Park4&key=#{ ENV["GOOGLE_DIRECTIONS_KEY"] }").
  #     # with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
  #     to_return(status: 200, body: HUGE_CRAP)
  # end
end
