[![Version](https://img.shields.io/gem/v/bridgetown_credentials.svg?style=flat)](https://rubygems.org/gems/bridgetown_credentials)
[![Tests](https://img.shields.io/github/actions/workflow/status/svoop/bridgetown_credentials/test.yml?style=flat&label=tests)](https://github.com/svoop/bridgetown_credentials/actions?workflow=Test)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/svoop/bridgetown_credentials.svg?style=flat)](https://codeclimate.com/github/svoop/bridgetown_credentials/)
[![Donorbox](https://img.shields.io/badge/donate-on_donorbox-yellow.svg)](https://donorbox.org/bitcetera)

# Credentials for Bridgetown

This plugin adds Rails-like encrypted credentials to Bridgetown.

Credentials like passwords, access tokens and other secrets are often passed to sites each by its own ENV variable. This is both uncool, non-atomic and therefore unreliable. Use this plugin to store your credentials in encrypted YAML files which you can safely commit to your source code repository. In order to use all of them in Bridgetown, you have to set or pass exactly one ENV variable holding the key to decrypt.

* [Homepage](https://github.com/svoop/bridgetown_credentials)
* [API](https://www.rubydoc.info/gems/bridgetown_credentials)
* Author: [Sven Schwyn - Bitcetera](https://bitcetera.com)

## Installation

First add this gem to your bundle:

```shell
$ bundle add bridgetown_credentials
```

Then enable it in `config/initializers.rb`:

```ruby
init :bridgetown_credentials
```

For the time being, it's necessary to [require this gem early in the boot process](https://www.bridgetownrb.com/docs/plugins/commands) for the commands to be picked up. Add `config/boot.rb` to your site reading:

```ruby
Bundler.setup(:default, Bridgetown.env)
require "bridgetown_credentials"
```

### Secure Installation

This gem is [cryptographically signed](https://guides.rubygems.org/security/#using-gems) in order to assure it hasn't been tampered with.

To install it securely, add the author's public key as a trusted certificate and then install the bundle with the trust policy of your choice:

```shell
gem cert --add <(curl -Ls https://raw.github.com/svoop/bridgetown_credentials/main/certs/svoop.pem)
bundle install --trust-policy MediumSecurity
```

## Update from 0.x.x to 1.x.x

From version 1.0.0 upwards, this gem uses [Dry::Credentials](https://rubygems.org/gems/dry-credentials) instead of ActiveSupport (which is planned to be ditched from Bridgetown at some point in the future). This requires you to take some additional steps:

1. Backup the decrypted credentials for every environment:<br>`bin/bridgetown credentials edit -e ENVIRONMENT`
2. Delete (or move elsewhere) your old encrypted credentials files:<br>`rm config/credentials/*`
3. Update this gem to a version >= 1:<br>`bundle update bridgetown_credentials`
4. Create new encrypted credentials files for every environment:<br>`bin/bridgetown credentials edit -e ENVIRONMENT`
5. Step 4 prints the new ENV variable which contains the private key required whenever you edit or query credentials. Example: For the development environment, the new ENV variable `DEVELOPMENT_CREDENTIALS_KEY` replaces the old ENV variable `BRIDGETOWN_DEVELOPMENT_KEY`.

Please note that Dry::Credentials does not support unified environments (one `config/credentials.yml.enc` for both development and production) anymore!

Also, nested credentials have to be queried differently now and thus you might have to update your Bridgetown site accordingly. Given the example credentials from the [Usage section](#usage) below:

```ruby
# Queries on version 0.x.x
Bridgetown.credentials.foo                            # => "bar"
Bridgetown.credentials.aws[:access_key_id]            # => "awsXid"
Bridgetown.credentials.google.dig((:maps, :api_key)   # => "goomXkey"

# Queries on version 1.x.x
Bridgetown.credentials.foo                            # => "bar"
Bridgetown.credentials.aws.access_key_id              # => "awsXid"
Bridgetown.credentials.google.maps.api_key            # => "goomXkey"
```

## Usage

### First Time

Make sure you have set the `EDITOR` variable to your favourite editor and then create a new credentials file:

```shell
echo $EDITOR
bin/bridgetown credentials edit
```

You might want to add something along the lines of:

```yml
foo: bar
aws:
  access_key_id: awsXid
  secret_access_key: awsXsecret
google:
  maps:
    api_key: goomXkey
  places:
    api_key: goopXkey
```

After saving, the private key required to encrypt/decrypt the credentials is printed this first time only. Make sure you store this information in a safe place, you will need it in the future.

The credentials you've edited above has been written to `config/credentials/development.yml.enc` and will be loaded when Bridgetown is in `development` mode.

To edit the credentials for `production` mode:

```shell
bin/bridgetown credentials edit -e production
```

To edit or query credentials from now on, the corresponding ENV variable with the private key has to be set:

```shell
export DEVELOPMENT_CREDENTIALS_KEY="4c87...af93"
export PRODUCTION_CREDENTIALS_KEY="92bb...820f"
```

### Edit

The command is the same as the first time:

```
bin/bridgetown credentials edit
bin/bridgetown credentials edit -e production
```

### Query

Throughout the Bridgetown stack, you can now use the credentials as follows:

```ruby
Bridgetown.credentials.foo                   # => "bar"
Bridgetown.credentials.aws.access_key_id     # => "awsXid"
Bridgetown.credentials.google.maps.api_key   # => "goomXkey"
```

## Tests

* `bundle exec rake test` to run the test suite
* `script/cibuild` to validate with Rubocop and Minitest together

## Development

You're welcome to [submit issues](https://github.com/svoop/bridgetown_credentials/issues) and contribute code by [forking the project and submitting pull requests](https://docs.github.com/en/get-started/quickstart/fork-a-repo).
