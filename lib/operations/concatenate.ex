defprotocol Concatenate do
  defstruct zip: &__MODULE__.zip/2
  def zip(a, b)
end

defimpl Concatenate, for: List do
  def zip(list_1, list_2) when is_list(list_2), do: list_1 ++ list_2
end

defimpl Concatenate, for: Map do
  def zip(map_1, map_2) when is_map(map_2), do: Map.merge(map_1, map_2)
end
