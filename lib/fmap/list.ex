defimpl Fmap, for: List do
  def apply(a, operation = %{fmap: fmap}) do
    Enum.map(a, fn x -> fmap.(x, operation) end)
  end

  def apply(a, fun) when is_function(fun) do
    Enum.map(a, fun)
  end
end
