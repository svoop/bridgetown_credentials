# frozen_string_literal: true

module BridgetownCredentials
  module Bridgetown

    def credentials
      BridgetownCredentials::Credentials.new(
        root_dir: ::Bridgetown.configuration.root_dir,
        env: ::Bridgetown.env
      ).credentials
    end

  end
end
