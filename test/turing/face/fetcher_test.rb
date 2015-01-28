require './test/test_helper'
require './lib/turing/face/fetcher'

class TuringFaceFetcherTest < Minitest::Test
  def test_it_exists
    assert Turing::Face::Fetcher
  end

  def test_it_fetches_a_file
    repo = "turingschool/tutorials"
    files = ["projects/store_engine.markdown"]
    fetcher = Turing::Face::Fetcher.new
    response = fetcher.fetch(repo, files)
    assert_equal repo, response.repo
    first_file = response.files.first
    assert_equal "projects/store_engine.markdown", first_file.path
    assert first_file.body.include?("# StoreEngine")
  end
end
