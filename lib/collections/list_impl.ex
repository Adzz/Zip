defimpl Zip, for: List do
  def apply(a, b, operation) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> operation.calculate(a, b) end)
  end
end
