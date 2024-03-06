# frozen_string_literal: true

require_relative "lib/bridgetown_credentials/version"

Gem::Specification.new do |spec|
  spec.name        = "bridgetown_credentials"
  spec.version     = BridgetownCredentials::VERSION
  spec.summary     = "Rails-like encrypted credentials for Bridgetown"
  spec.description = <<~END
    Credentials like passwords, access tokens and other secrets are often passed
    to sites each by it's own ENV variable. This is both uncool, non-atomic and
    therefore unreliable. Use this plugin to store your credentials in encrypted
    YAML files which you can safely commit to your source code repository. In
    order to use all of them in Bridgetown, you have to set or pass exactly one
    ENV variable holding the key to decrypt.
  END
  spec.authors       = ['Sven Schwyn']
  spec.email         = ['ruby@bitcetera.com']
  spec.homepage      = "https://github.com/svoop/bridgetown_credentials"
  spec.license       = "MIT"

  spec.metadata = {
    'homepage_uri'      => spec.homepage,
    'changelog_uri'     => 'https://github.com/svoop/bridgetown_credentials/blob/main/CHANGELOG.md',
    'source_code_uri'   => 'https://github.com/svoop/bridgetown_credentials',
    'documentation_uri' => 'https://www.rubydoc.info/gems/bridgetown_credentials',
    'bug_tracker_uri'   => 'https://github.com/svoop/bridgetown_credentials/issues'
  }

  spec.files         = Dir['lib/**/*']
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = %w(lib)

  spec.cert_chain  = ["certs/svoop.pem"]
  spec.signing_key = File.expand_path(ENV['GEM_SIGNING_KEY']) if ENV['GEM_SIGNING_KEY']

  spec.extra_rdoc_files = Dir['README.md', 'CHANGELOG.md', 'LICENSE.txt']
  spec.rdoc_options    += [
    '--title', 'Credentials for Bridgetown',
    '--main', 'README.md',
    '--line-numbers',
    '--inline-source',
    '--quiet'
  ]

  spec.required_ruby_version = ">= 3.0.0"

  spec.add_runtime_dependency "bridgetown", ">= 1.2.0", "< 2.0"
  spec.add_runtime_dependency "dry-credentials", "~> 0", ">= 0.2.1"

  spec.add_development_dependency 'debug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-flash'
  spec.add_development_dependency 'minitest-focus'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'yard'

  spec.post_install_message = "⚠️ Breaking change: bridgetown_credentials >= 1.0.0 no longer depends on ActiveSupport. Please read the update section in the README for how to migrate your Bridgetown site. Don't worry, it's a piece of cake!"
end
