require 'sinatra/base'

class Turing::Face::App < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
