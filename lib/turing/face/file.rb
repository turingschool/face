module Turing
  module Face
    class File
      attr_reader :path, :body

      def initialize(path, body)
        @path = path
        @body = body
      end
    end
  end
end
