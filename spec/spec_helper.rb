require 'simplecov'
require 'simplecov_json_formatter'

# Disable resultset & HTML completely
SimpleCov.formatters = [
  SimpleCov::Formatter::JSONFormatter
]

SimpleCov.start do
  add_filter '/spec/'
end

# Load app files explicitly
Dir[File.join(__dir__, '../lib/**/*.rb')].sort.each { |f| require f }
require_relative '../lib/calculator'

