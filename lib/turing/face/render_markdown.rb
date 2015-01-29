require 'redcarpet'
require 'pygmentize'

module Turing
  module Face
    class RenderMarkdown
      attr_reader :engine

      def initialize
        renderer = TuringFlavoredMarkdown.new
        @engine = Redcarpet::Markdown.new(renderer, extensions = {:fenced_code_blocks => true, :autolink => true})
      end

      def render(text)
        engine.render(text)
      end
    end

    class TuringFlavoredMarkdown < Redcarpet::Render::HTML
      def block_code(code, language)
        if language == "terminal"
          "<code class='terminal'>\n#{code}\n</code>"
        else
          Pygmentize.process(code, language)
        end
      end
    end
  end
end
