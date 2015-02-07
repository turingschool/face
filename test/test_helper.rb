require 'minitest/autorun'
require 'minitest/pride'
require 'vcr'
require 'rack/test'
require 'pry'
require 'capybara'
require 'capybara/dsl'

VCR.configure do |config|
  config.cassette_library_dir = "./test/support/vcr_cassettes"
  config.hook_into :webmock
end
