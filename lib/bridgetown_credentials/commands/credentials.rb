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
      def edit
        BridgetownCredentials::Commands.new.edit
      end

      desc "show", "Dump the decrypted credentials to STDOUT"
      def show
        BridgetownCredentials::Commands.new.show
      end
    end
  end
end
