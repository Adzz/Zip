defimpl Zip, for: List do
  def apply(a, b, %{calculate: calculate}) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> calculate.(a, b) end)
  end
end
