# frozen_string_literal: true

require "bridgetown"

require 'tempfile'
require 'yaml'
require "active_support/encrypted_configuration"

require_relative "bridgetown_credentials/version"
require_relative "bridgetown_credentials/credentials"
require_relative "bridgetown_credentials/commands"
require_relative "bridgetown_credentials/commands/credentials"
require_relative "bridgetown_credentials/bridgetown"

Bridgetown.initializer :bridgetown_credentials do
  Bridgetown.extend BridgetownCredentials::Bridgetown
end
