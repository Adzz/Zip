defprotocol Add do
  def calculate(a, b)
end

defimpl Add, for: Integer do
  def calculate(a, b), do: a + b
end

defimpl Add, for: Decimal do
  def calculate(decimal, decimal_2), do: Decimal.add(decimal, decimal_2)
end
