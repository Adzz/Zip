defprotocol Concatenate do
  defstruct calculate: &__MODULE__.calculate/2
  def calculate(a, b)
end

defimpl Concatenate, for: List do
  def calculate(list_1, list_2) when is_list(list_2), do: list_1 ++ list_2
end

defimpl Concatenate, for: Map do
  def calculate(map_1, map_2) when is_map(map_2), do: Map.merge(map_1, map_2)
end
