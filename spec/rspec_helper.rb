require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

require "rspec"
require_relative "../lib/syft_co"
require_relative "rule_spec"
require_relative "checkout_item_spec"
