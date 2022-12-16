# frozen_string_literal: true

module BridgetownCredentials
  class Builder < Bridgetown::Builder
    def build
      liquid_tag "bridgetown_credentials" do
        "This plugin works!"
      end
    end
  end
end
