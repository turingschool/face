require 'sinatra/base'
require 'json'
require 'pry'
require 'singleton'

module Turing
  module Face
    class App < Sinatra::Base
      get '/' do
        'Hello world!'
      end

      post '/changes' do
        data = JSON.parse(request.body.read)
        DataStore.instance.add_change
        status 200
      end

      get '/latest' do
        store = DataStore.instance
        {'changes' => store.changes}.to_json
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
    end
  end
end
