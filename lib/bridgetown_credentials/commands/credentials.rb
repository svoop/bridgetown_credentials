# frozen_string_literal: true

require_all "bridgetown-core/commands/concerns"

module BridgetownCredentials
  class Commands
    class Credentials < Thor
      Bridgetown::Commands::Registrations.register do
        desc "credentials <command>", "Work with encrypted credentials"
        subcommand "credentials", Credentials
      end

      desc "edit", "Edit (or create) encrypted credentials"
      option :environment, aliases: '-e'
      def edit
        BridgetownCredentials.initializer
        Bridgetown.credentials.edit! options['environment']
      end
    end
  end
end
