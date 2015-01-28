module Turing
  module Face
    class File
      attr_reader :path
      attr_accessor :body

      def initialize(path, body)
        @path = path
        @body = body
      end

      def ==(other)
        path == other.path
      end
    end
  end
end
