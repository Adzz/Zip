# defmodule Subtract do
#   defstruct calculate: &__MODULE__.calculate/2
#   @behaviour Operation

#   @impl true
#   def calculate(a, b) when is_integer(a) and is_integer(b), do: a - b
#   @impl true
#   def calculate(a = %Decimal{}, b = %Decimal{}), do: Decimal.sub(a, b)
# end

# Using protocols means we get extension, meaning
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

defimpl Subtract, for: List do
  def calculate(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Subtract{})
end

defimpl Subtract, for: Map do
  def calculate(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Subtract{})
end

# Streams
defimpl Subtract, for: Function do
  def calculate(stream, stream_2) when is_function(stream_2),
    do: Zip.apply(stream, stream_2, %Subtract{})
end