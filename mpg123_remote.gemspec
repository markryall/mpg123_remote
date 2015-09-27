# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mpg123_remote/version'

Gem::Specification.new do |spec|
  spec.name          = "mpg123_remote"
  spec.version       = Mpg123Remote::VERSION
  spec.authors       = ["Mark Ryall"]
  spec.email         = ["mark@ryall.name"]
  spec.summary       = %q{simple remote control for mpg123}
  spec.homepage      = "http://github.com/markryall/mpg123_remote"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'redis'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
