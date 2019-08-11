# defmodule Subtract do
#   defstruct zip: &__MODULE__.zip/2
#   @behaviour Operation

#   @impl true
#   def zip(a, b) when is_integer(a) and is_integer(b), do: a - b
#   @impl true
#   def zip(a = %Decimal{}, b = %Decimal{}), do: Decimal.sub(a, b)
# end

# Using protocols means we get extension, meaning
# we can define some implementations of the functions, and everyone else can implement their own.
# Otherwise we need to crack open the Subtract module and add implementations for zip there.

defprotocol Subtract do
  defstruct zip: &__MODULE__.zip/2
  def zip(a, b)
end

defimpl Subtract, for: Integer do
  def zip(a, b) when is_integer(b), do: a - b
end

defimpl Subtract, for: Decimal do
  def zip(a, b = %Decimal{}), do: Decimal.sub(a, b)
end

defimpl Subtract, for: List do
  def zip(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Subtract{})
end

defimpl Subtract, for: Map do
  def zip(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Subtract{})
end

# Streams
defimpl Subtract, for: Function do
  def zip(stream, stream_2) when is_function(stream_2),
    do: Zip.apply(stream, stream_2, %Subtract{})
end
