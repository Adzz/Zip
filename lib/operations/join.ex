defprotocol Join do
  defstruct zip: &__MODULE__.zip/2
  def zip(a, b)
end

defimpl Join, for: BitString do
  def zip(a, b) when is_binary(b) or is_bitstring(b), do: a <> b
end

defimpl Join, for: List do
  def zip(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Join{})
end

defimpl Join, for: Map do
  def zip(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Join{})
end

# Streams
defimpl Join, for: Function do
  def zip(stream, stream_2) when is_function(stream_2),
    do: Zip.apply(stream, stream_2, %Join{})
end
