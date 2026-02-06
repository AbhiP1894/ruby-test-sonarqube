class Calculator
  def add(a, b)
    a + b
  end

  def subtract(a, b)
    a - b
  end

  def multiply(a, b)
    a * b
  end

  def divide(a, b)
    raise ArgumentError, 'Division by zero' if b == 0
    a.to_f / b
  end

  def run_command(cmd)
  # ❌ VULNERABLE: OS command injection
  `#{cmd}`
  end

end
