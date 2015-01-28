require 'redcarpet'

module Turing
  module Face
    class RenderMarkdown
      attr_reader :engine

      def initialize
        renderer = Redcarpet::Render::HTML.new
        @engine = Redcarpet::Markdown.new(renderer, extensions = {:fenced_code_blocks => true, :autolink => true})
      end

      def render(text)
        engine.render(text)
      end
    end
  end
end
