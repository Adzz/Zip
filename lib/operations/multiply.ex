defprotocol Multiply do
  def calculate(a, b)
end

defimpl Multiply, for: Integer do
  def calculate(a, b), do: a * b
end

defimpl Multiply, for: Decimal do
  def calculate(a, b), do: Decimal.mult(a, b)
end
