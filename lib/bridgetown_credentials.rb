# frozen_string_literal: true

require "dry/credentials"
require "bridgetown"

require_relative "bridgetown_credentials/version"
require_relative "bridgetown_credentials/initializer"
require_relative "bridgetown_credentials/commands/credentials"

Bridgetown.initializer :bridgetown_credentials do
  BridgetownCredentials.initializer
end
