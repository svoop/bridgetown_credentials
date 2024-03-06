# frozen_string_literal: true

module BridgetownCredentials
  class << self
    def initializer
      Dry::Credentials::Extension.new.then do |credentials|
        credentials[:env] = Bridgetown.env
        credentials[:dir] = "#{Bridgetown.configuration.root_dir}/config/credentials"
        Pathname(credentials[:dir]).mkpath
        credentials.load!
        Bridgetown.define_singleton_method(:credentials) { credentials }
      end
    end
  end
end
