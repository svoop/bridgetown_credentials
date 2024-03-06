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
