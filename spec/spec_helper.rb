require 'simplecov'
require 'simplecov-cobertura'

SimpleCov::Formatter::CoberturaFormatter.class_eval do
  def output_filename
    'cobertura.xml'
  end
end

SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter


SimpleCov.start do
  add_filter '/spec/'
end

# Load app files explicitly
Dir[File.join(__dir__, '../lib/**/*.rb')].sort.each { |f| require f }
require_relative '../lib/calculator'

