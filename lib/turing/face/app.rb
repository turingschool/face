require 'bundler/setup'

require 'sinatra/base'
require 'json'
require 'pry'
require 'singleton'

require_relative 'fetcher'
require_relative 'data_store'

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
        response = fetcher.fetch(repo, files)
        data_store = DataStore.instance
        data_store.store(response)
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
  end
end
