defimpl Zip, for: Map do
  def apply(a, b, %{calculate: calculate}) do
    Enum.reduce(a, %{}, fn {key, value}, acc ->
      Map.put(acc, key, calculate.(value, Map.get(b, key)))
    end)
  end
end
