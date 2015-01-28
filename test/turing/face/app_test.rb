require './test/test_helper'
require './lib/turing/face/app'

class TuringFaceAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Turing::Face::App
  end

  def test_it_receives_post_data_from_github
    VCR.use_cassette("receives_post_data_from_github") do
      data = File.read('./test/support/sample_change.json')
      post '/changes', data, "CONTENT_TYPE" => "application/json"
      assert last_response.ok?
    end
  end

  def test_it_renders_content
    data = File.read('./test/support/sample_change.json')
    post '/changes', data, "CONTENT_TYPE" => "application/json"

    skip
    get '/projects/store_engine'
    assert last_response.ok?
    content = last_response.body
    refute content.include?("Second Change")

    data = File.read('./test/support/sample_change_two.json')
    post '/changes', data, "CONTENT_TYPE" => "application/json"

    get '/projects/store_engine'
    assert last_response.ok?
    content = last_response.body
    assert content.include?("Second Change")
  end
end
