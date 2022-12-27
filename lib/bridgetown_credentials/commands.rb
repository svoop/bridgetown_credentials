# frozen_string_literal: true

module BridgetownCredentials
  class Commands

    def initialize
      @credentials = BridgetownCredentials::Credentials.new
    end

    def edit
      tempfile = Tempfile.new('btcs')
      tempfile.write yaml
      tempfile.close
      system "#{ENV['EDITOR']} #{tempfile.path}"
      @credentials.credentials.write File.read(tempfile.path)
    ensure
      tempfile.unlink
    end

    def show
      puts yaml
    end

    private

    def yaml
      Psych.safe_dump(@credentials.config)[4..] if @credentials.config.any?
    end
  end
end
