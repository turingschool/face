require 'bundler/setup'

require 'sinatra/base'
require 'json'
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
        DataStore.instance.store(response)
        status 200
      end

      get '/latest' do
        store = DataStore.instance
        {'changes' => store.changes}.to_json
      end

      get '/:group/*' do |group, name|
        data_store = DataStore.instance
        page = data_store.find(group, name)
        if page
          page.body
        else
          status(404)
        end
      end
    end
  end
end
