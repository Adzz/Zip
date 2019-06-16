defimpl Zip, for: List do
  def apply(a, b, %{calculate: calculate}) do
    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> calculate.(a, b) end)
  end
end
