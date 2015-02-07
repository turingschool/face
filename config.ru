require './lib/turing/face/app'
Sass::Plugin.options[:template_location] = 'public/stylesheets/sass'
use Sass::Plugin::Rack
run Turing::Face::App
