module Turing
  module Face

    class DataStore
      include Singleton

      attr_reader :changes
      attr_reader :data

      def initialize
        @changes = 0
        @data = []
      end

      def add_change
        @changes += 1
      end

      def find(group, target_name)
        @data.detect{|file| file.path.include?(target_name)}
      end

      def store(response)
        response.files.each do |file|
          @data << file
        end
        add_change
      end
    end

  end
end
