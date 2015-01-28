require './test/test_helper'
require './lib/turing/face/render_pipeline'
require './lib/turing/face/file'
require './lib/turing/face/fetcher'

class RenderPipelineTest < Minitest::Test
  def test_it_renders_a_markdown_header
    renderer = Turing::Face::RenderPipeline.new

    fake_file = Turing::Face::File.new('projects/feed_engine', "# Feed Engine\n\nThis is the engine of feeds.")
    fake_response = Turing::Face::FetcherResponse.new('turingschool/curriculum')
    fake_response.add(fake_file)

    rendered_response = renderer.render(fake_response)
    assert rendered_response.files.first.body.include?("<h1>Feed Engine</h1>")
  end
end
