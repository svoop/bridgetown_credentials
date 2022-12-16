# frozen_string_literal: true

require_relative "lib/bridgetown_credentials/version"

Gem::Specification.new do |spec|
  spec.name          = "bridgetown_credentials"
  spec.version       = BridgetownCredentials::VERSION
  spec.authors       = ['Sven Schwyn']
  spec.email         = ['ruby@bitcetera.com']
  spec.summary       = "Rails-like encrypted credentials for Bridgetown"
  spec.homepage      = "https://github.com/svoop/bridgetown_credentials"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend)/!) }
  spec.test_files    = spec.files.grep(%r!^test/!)
  spec.require_paths = ["lib"]
  spec.metadata      = { "yarn-add" => "bridgetown_credentials@#{BridgetownCredentials::VERSION}" }

  spec.required_ruby_version = ">= 3.0.0"

  spec.add_dependency "bridgetown", "= 1.2.0.beta4", "< 2.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", ">= 13.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.3"
end
