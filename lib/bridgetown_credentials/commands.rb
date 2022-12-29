# frozen_string_literal: true

module BridgetownCredentials
  class Commands

    def initialize(root_dir: ::Bridgetown.configuration.root_dir, env: ::Bridgetown.env)
      @credentials = BridgetownCredentials::Credentials.new(root_dir: root_dir, env: env)
    end

    def edit
      tempfile = Tempfile.new('btcs')
      tempfile.write @credentials.credentials.read
      tempfile.close
      system "#{ENV['EDITOR']} #{tempfile.path}"
      @credentials.credentials.write File.read(tempfile.path)
    ensure
      tempfile.unlink
    end

    def show
      puts @credentials.credentials.read
    end
  end
end
