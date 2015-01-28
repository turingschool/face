require 'minitest/autorun'
require './lib/turing/face/data_store'
require './lib/turing/face/fetcher'

class TuringFaceDataStoreTest < Minitest::Test
  def test_it_exists
    assert Turing::Face::DataStore
  end

  def test_it_stores_responses
    ds = Turing::Face::DataStore.instance

    fake_file = Turing::Face::FetcherFile.new('projects/feed_engine', '# Feed Engine\n\nThis is the engine of feeds.')
    fake_response = Turing::Face::FetcherResponse.new('turingschool/curriculum')
    fake_response.add(fake_file)

    assert ds.store(fake_response)
    data = ds.find('curriculum', 'projects/feed_engine')
    assert data.body.include?('# Feed Engine')
  end

  def test_it_counts_insertions
    ds = Turing::Face::DataStore.instance
    start = ds.changes
    fake_response = Turing::Face::FetcherResponse.new('turingschool/curriculum')

    ds.store(fake_response)
    one = ds.changes
    assert one > start

    ds.store(fake_response)
    two = ds.changes
    assert two > one
  end
end
