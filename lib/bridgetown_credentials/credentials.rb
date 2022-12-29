# frozen_string_literal: true

module BridgetownCredentials
  class Credentials

    attr_reader :credentials

    def initialize(root_dir:, env:)
      @config_path = Pathname(root_dir).join('config')   # NOTE: config dir is hardcoded as of bridgetown-1.2
      @env = env
      @credentials = credentials_path ? load : create
    end

    private

    def credentials_path
      [
        @config_path.join("credentials.yml.enc"),
        default_credentials_path
      ].find do |path|
        path.file?
      end
    end

    def credentials_env
      ['BRIDGETOWN', credentials_path.basename('.yml.enc'), 'KEY']
        .join('_')
        .upcase
    end

    def default_credentials_path
      @config_path.join('credentials', "#{@env}.yml.enc")
    end

    def default_key_path
      @config_path.join('credentials', "#{@env}.key")
    end

    def load
      ActiveSupport::EncryptedConfiguration.new(
        config_path: credentials_path,
        env_key: credentials_env,
        key_path: '---',
        raise_if_missing_key: true
      )
    end

    def create
      default_key_path.dirname.mkpath
      default_key_path.write(ActiveSupport::EncryptedConfiguration.generate_key)
      ActiveSupport::EncryptedConfiguration.new(
        config_path: default_credentials_path,
        env_key: '---',
        key_path: default_key_path,
        raise_if_missing_key: false
      )
    end

  end
end
