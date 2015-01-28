require 'faraday'
require_relative 'file'

module Turing
  module Face
    class Fetcher
      def fetch(repo, files)
        response = FetcherResponse.new(repo)
        files.each do |file|
          url = "https://raw.githubusercontent.com/#{repo}/master/#{file}"
          data = Faraday.get(url).body
          file = Turing::Face::File.new(file, data)
          response.add(file)
        end
        response
      end
    end

    class FetcherResponse
      attr_reader :repo
      attr_reader :files

      def initialize(repo)
        @repo = repo
        @files = []
      end

      def add(file)
        @files << file
      end
    end
  end
end
