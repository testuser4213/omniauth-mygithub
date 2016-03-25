# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-mygithub/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-mygithub"
  spec.version       = OmniAuth::MyGitHub::VERSION
  spec.authors       = ["Test User"]
  spec.email         = ["testuser4213@zoho.com"]

  spec.summary       = %q{Simple omniauth strategy for GitHub}
  spec.description   = %q{Simple omniauth strategy for GitHub}
  spec.homepage      = "https://github.com/testuser4213/omniauth-mygithub"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 1.3.0"
  spec.add_dependency "omniauth-oauth2", "~> 1.4.0"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
end
