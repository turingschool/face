require './test/test_helper'
require './lib/turing/face/render_markdown'

class RenderMarkdownTest < Minitest::Test
  def test_it_renders_a_header
    renderer = Turing::Face::RenderMarkdown.new
    output = renderer.render("# Hello, World").strip
    assert_equal "<h1>Hello, World</h1>", output
  end
end
