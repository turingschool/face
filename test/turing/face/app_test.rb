require 'minitest/autorun'
require './lib/turing/face/app'
require 'rack/test'
require "rack-minitest/test"

class TuringFaceAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Turing::Face::App
  end

  def test_it_receives_post_data_from_github
    data = File.read('./test/support/sample_change.json')
    post '/changes', data, "CONTENT_TYPE" => "application/json"
    assert last_response.ok?
  end

  def test_it_accumulates_change_data
    get '/latest'
    original = JSON.parse(last_response.body)['changes']
    data = File.read('./test/support/sample_change.json')

    post '/changes', data, "CONTENT_TYPE" => "application/json"
    get '/latest'
    one = JSON.parse(last_response.body)['changes']
    assert_equal original + 1, one

    post '/changes', data, "CONTENT_TYPE" => "application/json"
    get '/latest'
    two = JSON.parse(last_response.body)['changes']
    assert_equal one + 1, two
  end
end
