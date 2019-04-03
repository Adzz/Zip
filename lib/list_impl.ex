defimpl Zip, for: List do
  def apply(a, b, operation) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    a
    |> Enum.with_index()
    |> Enum.map(fn {item, index} ->
      operation.calculate(item, Enum.at(b, index))
    end)
  end
end
