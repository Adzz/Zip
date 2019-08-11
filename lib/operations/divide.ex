# defmodule Divide do
#   defstruct zip: &__MODULE__.zip/2
#   @behaviour Operation

#   @impl true
#   def zip(a, b) when is_integer(a) and is_integer(b), do: a / b
#   @impl true
#   def zip(a = %Decimal{}, b = %Decimal{}), do: Decimal.div(a, b)
# end

# Alternative with protocols. Using a behaviour allows us to ensure that
# the module implements a function, which we can call in all of the
# implementations of the Zip protocol. But using protocols means we get extension, meaning
# we can define some implementations of the functions, and everyone else can implement their own

defprotocol Divide do
  defstruct zip: &__MODULE__.zip/2
  def zip(a, b)
end

defimpl Divide, for: Integer do
  def zip(a, b) when is_integer(b), do: a / b
end

defimpl Divide, for: Decimal do
  def zip(a, b = %Decimal{}), do: Decimal.div(a, b)
end

defimpl Divide, for: List do
  def zip(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Divide{})
end

defimpl Divide, for: Map do
  def zip(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Divide{})
end

# Streams
defimpl Divide, for: Function do
  def zip(stream, stream_2) when is_function(stream_2),
    do: Zip.apply(stream, stream_2, %Divide{})
end
