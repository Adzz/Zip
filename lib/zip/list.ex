defimpl Zip, for: List do
  # The case for our homemade operations
  def apply(a, b, %{zip: zip}) do
    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> zip.(a, b) end)
  end

  # falls-back to calling the function if it's not type we defined
  def apply(a, b, fun) when is_function(fun) do
    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> fun.(a, b) end)
  end
end
