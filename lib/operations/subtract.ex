# defmodule Subtract do
#   defstruct calculate: &__MODULE__.calculate/2
#   @behaviour Operation

#   @impl true
#   def calculate(a, b) when is_integer(a) and is_integer(b), do: a - b
#   @impl true
#   def calculate(a = %Decimal{}, b = %Decimal{}), do: Decimal.sub(a, b)
# end

# Using a behaviour allows us to ensure that
# the module implements a function, which we can call in all of the
# implementations of the Zip protocol. But using protocols means we get extension, meaning
# we can define some implementations of the functions, and everyone else can implement their own.
# Otherwise we need to crack open the Subtract module and add implementations for calculate there.

defprotocol Subtract do
  defstruct calculate: &__MODULE__.calculate/2
  def calculate(a, b)
end

defimpl Subtract, for: Integer do
  def calculate(a, b) when is_integer(b), do: a - b
end

defimpl Subtract, for: Decimal do
  def calculate(a, b = %Decimal{}), do: Decimal.sub(a, b)
end
