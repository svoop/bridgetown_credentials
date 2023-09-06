# frozen_string_literal: true

gem 'minitest'

require 'bridgetown'
Bridgetown::Site.new(Bridgetown.configuration())

require 'debug'
require 'pathname'

require 'minitest/autorun'
require Pathname(__dir__).join('..', 'lib', 'bridgetown_credentials')

require 'minitest/flash'
require 'minitest/focus'

class Minitest::Spec
  class << self
    alias_method :context, :describe
  end
end

def fixtures_path
  Pathname(__dir__).join('fixtures')
end

KEYS = {
  unified: '4f9ab3ef4bddd3ad6d01886b6ffff49c',
  development: 'e4af0afc87c885a430afa3c9691d8bf4',
  production: '5f1380543df0a4c839324619e0acf0bf'
}
