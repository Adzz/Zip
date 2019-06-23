defprotocol Join do
  defstruct calculate: &__MODULE__.calculate/2
  def calculate(a, b)
end

defimpl Join, for: BitString do
  def calculate(a, b) when is_binary(b) or is_bitstring(b), do: a <> b
end

defimpl Join, for: List do
  def calculate(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Join{})
end

defimpl Join, for: Map do
  def calculate(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Join{})
end

# Streams
defimpl Join, for: Function do
  def calculate(stream, stream_2) when is_function(stream_2),
    do: Zip.apply(stream, stream_2, %Join{})
end
