defprotocol Subtract do
  def calculate(a, b)
end

defimpl Subtract, for: Integer do
  def calculate(a, b), do: a - b
end

defimpl Subtract, for: Decimal do
  def calculate(a, b), do: Decimal.sub(a, b)
end
