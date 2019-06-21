# defmodule Divide do
#   defstruct calculate: &__MODULE__.calculate/2
#   @behaviour Operation

#   @impl true
#   def calculate(a, b) when is_integer(a) and is_integer(b), do: a / b
#   @impl true
#   def calculate(a = %Decimal{}, b = %Decimal{}), do: Decimal.div(a, b)
# end

# Alternative with protocols. Using a behaviour allows us to ensure that
# the module implements a function, which we can call in all of the
# implementations of the Zip protocol. But using protocols means we get extension, meaning
# we can define some implementations of the functions, and everyone else can implement their own

defprotocol Divide do
  defstruct calculate: &__MODULE__.calculate/2
  def calculate(a, b)
end

defimpl Divide, for: Integer do
  def calculate(a, b) when is_integer(b), do: a / b
end

defimpl Divide, for: Decimal do
  def calculate(a, b = %Decimal{}), do: Decimal.div(a, b)
end

defimpl Divide, for: List do
  def calculate(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Divide{})
end

defimpl Divide, for: Map do
  def calculate(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Divide{})
end

# Streams
defimpl Divide, for: Function do
  def calculate(stream, stream_2) when is_function(stream_2),
    do: Zip.apply(stream, stream_2, %Divide{})
end
