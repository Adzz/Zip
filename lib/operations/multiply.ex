defmodule Multiply do
  @behaviour Operation

  @impl true
  def calculate(a, b) when is_integer(a) and is_integer(b), do: a * b
  @impl true
  def calculate(a = %Decimal{}, b = %Decimal{}), do: Decimal.mult(a, b)
end

# defprotocol Multiply do
#   def calculate(a, b)
# end

# defimpl Multiply, for: Integer do
#   def calculate(a, b), do: a * b
# end

# defimpl Multiply, for: Decimal do
#   def calculate(a, b), do: Decimal.mult(a, b)
# end
