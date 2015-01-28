require_relative 'render_markdown'

module Turing
  module Face
    class RenderPipeline
      attr_reader :pipeline

      def initialize
        @pipeline = [RenderMarkdown.new]
      end

      def render(response)
        response.files.each do |file|
          render_file(file)
        end
        response
      end

      def render_file(file)
        pipeline.each do |stage|
          file.body = stage.render(file.body)
        end
      end
    end
  end
end
