require './test/test_helper'
require './lib/turing/face/app'

class TuringFaceAppTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    Turing::Face::DataStore.instance.clear
  end

  def app
    Turing::Face::App
  end

  def test_it_receives_post_data_from_github
    skip
    VCR.use_cassette("receives_post_data_from_github") do
      data = File.read('./test/support/sample_change.json')
      post '/changes', data, "CONTENT_TYPE" => "application/json"
      assert last_response.ok?
    end
  end

  def test_it_renders_a_page
    skip
    VCR.use_cassette("renders_a_page") do
      get 'tutorials/projects/store_engine'
      assert_equal 404, last_response.status

      data = File.read('./test/support/sample_change.json')
      post '/changes', data, "CONTENT_TYPE" => "application/json"
      assert last_response.ok?

      get 'tutorials/projects/store_engine'
      assert last_response.ok?
      assert last_response.body.include?("# StoreEngine")
    end
  end

  def test_it_renders_updated_content
    VCR.use_cassette("it_renders_updated_content") do
      data = File.read('./test/support/sample_change.json')
      post '/changes', data, "CONTENT_TYPE" => "application/json"

      get 'tutorials/projects/store_engine'
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
end
