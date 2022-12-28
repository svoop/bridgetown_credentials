# frozen_string_literal: true

require_all "bridgetown-core/commands/concerns"

module BridgetownCredentials
  class Commands
    class Credentials < Thor
      Bridgetown::Commands::Registrations.register do
        desc "credentials <command>", "Work with Rails-like encrypted credentials"
        subcommand "credentials", Credentials
      end

      desc "edit", "Edit the credentials"
      option :environment, aliases: '-e'
      def edit
        ENV['BRIDGETOWN_ENV'] = options['environment'] if options['environment']
        BridgetownCredentials::Commands.new.edit
      end

      desc "show", "Dump the decrypted credentials to STDOUT"
      option :environment, aliases: '-e'
      def show
        ENV['BRIDGETOWN_ENV'] = options['environment'] if options['environment']
        BridgetownCredentials::Commands.new.show
      end
    end
  end
end
