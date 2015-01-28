require 'bundler/setup'

require 'sinatra/base'
require 'json'
require 'singleton'

require_relative 'fetcher'
require_relative 'data_store'
require_relative 'render_pipeline'

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
        modified_files = data['commits'].collect{|c| c['modified']}.flatten!
        added_files = data['commits'].collect{|c| c['added']}.flatten!
        files = modified_files + added_files
        response = fetcher.fetch(repo, files)
        renderer = RenderPipeline.new
        rendered_response = renderer.render(response)
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
