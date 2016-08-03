require 'simplecov'
SimpleCov.start("rails")

require 'omniauth-twitter'
require 'pry'
require 'vcr'
require 'database_cleaner'



VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

def mock_auth_hash
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    'provider' => 'twitter',
    'uid' => '123545',
    'info' => {image: 'image.jpg'},
    'extra' => {
      'raw_info' => {
        'screen_name' => 'mock_user_name'
      },
    },
    'credentials' => {
      'token' => '11112222',
      'secret' => '1234567890'
    },
  })
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
