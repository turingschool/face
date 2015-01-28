require 'bundler/setup'

require 'sinatra/base'
require 'json'
require 'pry'
require 'singleton'

require_relative 'fetcher'

module Turing
  module Face
    class App < Sinatra::Base
      get '/' do
        'Hello world!'
      end

      post '/changes' do
        data = JSON.parse(request.body.read)
        fetcher = Fetcher.new
        repo = data['repository']['full_name']
        files = data['commits'].collect{|c| c['modified']}.flatten!
        fetcher.fetch(repo, files)
        DataStore.instance.add_change
        status 200
      end

      get '/latest' do
        store = DataStore.instance
        {'changes' => store.changes}.to_json
      end

      get '/projects/:name' do |name|
        data_store = DataStore.instance
        data_store.find(:projects, name)
      end
    end

    class DataStore
      include Singleton

      attr_reader :changes

      def initialize
        @changes = 0
      end

      def add_change
        @changes += 1
      end

      def find

      end
    end
  end
end
