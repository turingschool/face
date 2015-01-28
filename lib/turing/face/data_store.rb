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

      def remove_if_existing(response)
        response.files.each do |file|
          existing = find(nil, file.path)
          if existing
            data.delete(existing)
          end
        end
      end

      def store(response)
        remove_if_existing(response)
        response.files.each do |file|
          @data << file
        end
        add_change
      end

      def clear
        @data = []
        @changes = 0
      end
    end
  end
end
