defprotocol Multiply do
  defstruct zip: &__MODULE__.zip/2
  def zip(a, b)
end

defimpl Multiply, for: Integer do
  def zip(a, b) when is_integer(b), do: a * b
end

defimpl Multiply, for: Decimal do
  def zip(a, b = %Decimal{}), do: Decimal.mult(a, b)
end

defimpl Multiply, for: List do
  def zip(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Multiply{})
end

defimpl Multiply, for: Map do
  def zip(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Multiply{})
end

# Streams
defimpl Multiply, for: Function do
  def zip(stream, stream_2) when is_function(stream_2),
    do: Zip.apply(stream, stream_2, %Multiply{})
end
