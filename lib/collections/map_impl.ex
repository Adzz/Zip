defimpl Zip, for: Map do
  def apply(a, b, %{calculate: calculate}) do
    overlapping_map = Map.take(b, Map.keys(a))

    Enum.reduce(a, %{}, fn {key, value}, acc ->
      Map.put(acc, key, calculate.(value, Map.fetch!(overlapping_map, key)))
    end)
  end
end
