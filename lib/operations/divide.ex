defprotocol Divide do
  def calculate(a, b)
end

defimpl Divide, for: Integer do
  def calculate(a, b), do: a / b
end

defimpl Divide, for: Decimal do
  def calculate(a, b), do: Decimal.div(a, b)
end
