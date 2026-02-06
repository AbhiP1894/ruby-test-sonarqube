require 'spec_helper'

RSpec.describe Calculator do
  let(:calculator) { Calculator.new }

  describe '#add' do
    it 'adds two numbers' do
      expect(calculator.add(2, 3)).to eq(5)
    end
  end

  describe '#subtract' do
    it 'subtracts two numbers' do
      expect(calculator.subtract(5, 3)).to eq(2)
    end
  end

  describe '#multiply' do
    it 'multiplies two numbers' do
      expect(calculator.multiply(4, 3)).to eq(12)
    end
  end

  describe '#divide' do
    it 'divides two numbers' do
      expect(calculator.divide(10, 2)).to eq(5.0)
    end

    it 'raises error when dividing by zero' do
      expect { calculator.divide(10, 0) }
        .to raise_error(ArgumentError, 'Division by zero')
    end
  end
end
