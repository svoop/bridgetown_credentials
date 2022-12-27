[![Version](https://img.shields.io/gem/v/bridgetown_credentials.svg?style=flat)](https://rubygems.org/gems/bridgetown_credentials)
[![Tests](https://img.shields.io/github/actions/workflow/status/svoop/bridgetown_credentials/test.yml?style=flat&label=tests)](https://github.com/svoop/bridgetown_credentials/actions?workflow=Test)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/svoop/bridgetown_credentials.svg?style=flat)](https://codeclimate.com/github/svoop/bridgetown_credentials/)
[![Donorbox](https://img.shields.io/badge/donate-on_donorbox-yellow.svg)](https://donorbox.org/bitcetera)

# Credentials for Bridgetown

This plugin adds Rails-like encrypted credentials to Bridgetown.

Credentials like passwords, access tokens and other secrets are often passed to sites each by it's own ENV variable. This is both uncool, non-atomic and therefore unreliable. Use this plugin to store your credentials in encrypted YAML files which you can safely commit to your source code repository. In order to use all of them in Bridgetown, you have to set or pass exactly one ENV variable holding the key to decrypt.

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

For safety, you should exclude key files from the source code repository:

```shell
bin/bridgetown apply "$(bundle info --path bridgetown_credentials)/bridgetown.automation.rb"
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

After saving the file, the following new files have been created:

```
config/
 └─ credentials/
     ├─ development.key
     └─ development.yml.enc
```

⚠️ Move the `*.key` files to a safe place such as a password manager now! Never check them into the source code repository!

The credentials you've edited above have been written to `development.yml.enc` and will be available when Bridgetown is in `development` mode.

To edit the credentials for `production` mode:

```shell
bin/bridgetown credentials edit -e production
```

To edit or use a credentials file from now on, you have to set the corresponding key as an ENV variable. The actual key is the content of the `*.key` file you should have tucked away above.

```shell
export BRIDGETOWN_DEVELOPMENT_KEY="10aabbccddeeff00112233445566778899"
export BRIDGETOWN_PRODUCTION_KEY="20aabbccddeeff00112233445566778899"
```

#### Unified Environments

If you prefer not to separate credentials between different environments:

```shell
rm config/credentials/production.*
mv config/credentials/development.yml config/credentials.yml
rmdir config/credentials
```

This simplifies the files to:

```
config/
 └─ credentials.yml.enc
```

To edit or use this from now on, you have to set:


```shell
export BRIDGETOWN_CREDENTIALS_KEY="30aabbccddeeff00112233445566778899"
```

⚠️ If `config/credentials.yml` is present, any other credentials files are ignored.

### Read

Throughout the Bridgetown stack, you can now use the credentials as follows:

```ruby
Bridgetown.credentials.foo                            # => "bar"
Bridgetown.credentials.aws[:access_key_id]            # => "awsXid"
Bridgetown.credentials.google.dig((:maps, :api_key)   # => "goomXkey"
```

### Commands

* `bin/bridgetown credentials edit` – edit the credentials
* `bin/bridgetown credentials show` – dump the decrypted credentials to STDOUT

## Tests

* `bundle exec rake test` to run the test suite
* `script/cibuild` to validate with Rubocop and Minitest together

## Development

You're welcome to [submit issues](https://github.com/svoop/bridgetown_credentials/issues) and contribute code by [forking the project and submitting pull requests](https://docs.github.com/en/get-started/quickstart/fork-a-repo).
