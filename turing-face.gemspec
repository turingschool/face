# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turing/face/version'

Gem::Specification.new do |spec|
  spec.name          = "turing-face"
  spec.version       = Turing::Face::VERSION
  spec.authors       = ["Jeff Casimir"]
  spec.email         = ["jeff@casimircreative.com"]
  spec.summary       = "A rendering engine for git-based text."
  spec.description   = "A rendering engine for git-based text."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rack-minitest"
  spec.add_development_dependency "vcr"
  spec.add_dependency 'rack', '1.5.2'
  spec.add_dependency 'slim', '2.0.3'
  spec.add_dependency 'temple', '0.6.8'
  spec.add_dependency "shotgun"
  #spec.add_dependency "sinatra"
  spec.add_dependency "json"
  spec.add_dependency "tilt"
  spec.add_dependency "faraday"
end
