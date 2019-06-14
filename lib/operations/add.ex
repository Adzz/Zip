defmodule Add do
  @behaviour Operation

  @impl true
  def calculate(a, b) when is_integer(a) and is_integer(b), do: a + b
  @impl true
  def calculate(a = %Decimal{}, b = %Decimal{}), do: Decimal.add(a, b)
end

# Alternative with protocols. Using a behaviour allows us to ensure that
# the module implements a function, which we can call in all of the
# implementations of the Zip protocol.
# defprotocol Add do
#   def calculate(a, b)
# end

# defimpl Add, for: Integer do
#   def calculate(a, b), do: a + b
# end

# defimpl Add, for: Decimal do
#   def calculate(decimal, decimal_2), do: Decimal.add(decimal, decimal_2)
# end
