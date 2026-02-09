require 'simplecov'
begin
  require 'simplecov-json'
rescue LoadError
  # simplecov-json not installed; fallback to built-in JSON formatter if available
end
require 'simplecov-cobertura'

SimpleCov::Formatter::CoberturaFormatter.class_eval do
  def output_filename
    'cobertura.xml'
  end
end

# Configure multi-formatter: prefer JSON formatter (built-in or gem) + Cobertura
formatters = []
formatters << SimpleCov::Formatter::CoberturaFormatter
if defined?(SimpleCov::Formatter::JSONFormatter)
  formatters << SimpleCov::Formatter::JSONFormatter
elsif defined?(SimpleCov::Formatter::JsonFormatter)
  formatters << SimpleCov::Formatter::JsonFormatter
end

if formatters.size > 1
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)
else
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

SimpleCov.start do
  add_filter '/spec/'
end

# Load app files explicitly
Dir[File.join(__dir__, '../lib/**/*.rb')].sort.each { |f| require f }
require_relative '../lib/calculator'

